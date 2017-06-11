#include "proxymodel.h"
#include <QtDebug>
#include <QtQml>

ProxyModel::ProxyModel(QObject *parent) : QSortFilterProxyModel(parent), m_complete(false)
{
    connect(this, SIGNAL(rowsInserted(QModelIndex,int,int)), this, SIGNAL(countChanged()));
    connect(this, SIGNAL(rowsRemoved(QModelIndex,int,int)), this, SIGNAL(countChanged()));
}

int ProxyModel::count() const
{
    return rowCount();
}

QObject *ProxyModel::source() const
{
    return sourceModel();
}

void ProxyModel::setSource(QObject *source)
{
    setSourceModel(qobject_cast<QAbstractItemModel *>(source));
}

QByteArray ProxyModel::sortRole() const
{
    return m_sortRole;
}

void ProxyModel::setSortRole(const QByteArray &role)
{
    if (m_sortRole != role) {
        m_sortRole = role;
        if (m_complete)
            QSortFilterProxyModel::setSortRole(roleKey(role));
    }
}

void ProxyModel::setSortOrder(Qt::SortOrder order)
{
    QSortFilterProxyModel::sort(0, order);
}

QByteArray ProxyModel::filterRole() const
{
    return m_filterRole;
}

void ProxyModel::setFilterRole(const QByteArray &role)
{
    if (m_filterRole != role) {
        m_filterRole = role;
        if (m_complete)
            QSortFilterProxyModel::setFilterRole(roleKey(role));
    }
}

QString ProxyModel::filterString() const
{
    return filterRegExp().pattern();
}

void ProxyModel::setFilterString(const QString &filter)
{
    setFilterRegExp(QRegExp(filter, filterCaseSensitivity(), static_cast<QRegExp::PatternSyntax>(filterSyntax())));
}

ProxyModel::FilterSyntax ProxyModel::filterSyntax() const
{
    return static_cast<FilterSyntax>(filterRegExp().patternSyntax());
}

void ProxyModel::setFilterSyntax(ProxyModel::FilterSyntax syntax)
{
    setFilterRegExp(QRegExp(filterString(), filterCaseSensitivity(), static_cast<QRegExp::PatternSyntax>(syntax)));
}

QJSValue ProxyModel::get(int idx) const
{
    QJSEngine *engine = qmlEngine(this);
    QJSValue value = engine->newObject();
    if (idx >= 0 && idx < count()) {
        QHash<int, QByteArray> roles = roleNames();
        QHashIterator<int, QByteArray> it(roles);
        while (it.hasNext()) {
            it.next();
            value.setProperty(QString::fromUtf8(it.value()), data(index(idx, 0), it.key()).toString());
        }
    }
    return value;
}

void ProxyModel::classBegin()
{
}

void ProxyModel::componentComplete()
{
    m_complete = true;
    if (!m_sortRole.isEmpty())
        QSortFilterProxyModel::setSortRole(roleKey(m_sortRole));
    if (!m_filterRole.isEmpty())
        QSortFilterProxyModel::setFilterRole(roleKey(m_filterRole));
}

int ProxyModel::roleKey(const QByteArray &role) const
{
    QHash<int, QByteArray> roles = roleNames();
    QHashIterator<int, QByteArray> it(roles);
    while (it.hasNext()) {
        it.next();
        if (it.value() == role)
            return it.key();
    }
    return -1;
}

QHash<int, QByteArray> ProxyModel::roleNames() const
{
    if (QAbstractItemModel *source = sourceModel())
        return source->roleNames();
    return QHash<int, QByteArray>();
}

bool ProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QRegExp rx = filterRegExp();
    if (rx.isEmpty())
        return true;
    QAbstractItemModel *model = sourceModel();
    if (filterRole().isEmpty()) {
        QHash<int, QByteArray> roles = roleNames();
        QHashIterator<int, QByteArray> it(roles);
        while (it.hasNext()) {
            it.next();
            QModelIndex sourceIndex = model->index(sourceRow, 0, sourceParent);
            QString key = model->data(sourceIndex, it.key()).toString();
            if (key.contains(rx))
                return true;
        }
        return false;
    }
    QModelIndex sourceIndex = model->index(sourceRow, 0, sourceParent);
    if (!sourceIndex.isValid())
        return true;
    QString key = model->data(sourceIndex, roleKey(filterRole())).toString();
    return key.contains(rx);
}

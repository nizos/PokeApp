#ifndef CURSORPOSPROVIDER_H
#define CURSORPOSPROVIDER_H
#include <Qobject>
#include <QPointF>
#include <QCursor>


class CursorPosProvider : public QObject
{
    Q_OBJECT
public:
    explicit CursorPosProvider(QObject *parent = nullptr) : QObject(parent)
    {
    }
    virtual ~CursorPosProvider() = default;

    Q_INVOKABLE QPointF cursorPos()
    {
        return QCursor::pos();
    }
};

#endif // CURSORPOSPROVIDER_H

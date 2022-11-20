#pragma once
#include <QObject>
#include <QUrl>
#include <QUuid>
#include <vector>
#include "book.hpp"
#include "book_operation_status.hpp"
#include "tag.hpp"

namespace application
{

/*
 *  The BookService handles all the operations on books.
 */
class IBookService : public QObject
{
    Q_OBJECT

public:
    virtual ~IBookService() noexcept = default;

    virtual BookOperationStatus addBook(const QString& filePath) = 0;
    virtual BookOperationStatus deleteBook(const QUuid& uuid) = 0;
    virtual BookOperationStatus uninstallBook(const QUuid& uuid) = 0;
    virtual BookOperationStatus updateBook(
        const domain::models::Book& newBook) = 0;

    virtual const std::vector<domain::models::Book>& getBooks() const = 0;
    virtual const domain::models::Book* getBook(const QUuid& uuid) const = 0;
    virtual domain::models::Book* getBook(const QUuid& uuid) = 0;
    virtual int getBookIndex(const QUuid& uuid) const = 0;
    virtual int getBookCount() const = 0;

    virtual BookOperationStatus addTag(const QUuid& uuid,
                                       const domain::models::Tag& tag) = 0;
    virtual BookOperationStatus removeTag(const QUuid& uuid,
                                          const domain::models::Tag& tag) = 0;

    virtual BookOperationStatus saveBookToFile(const QUuid& uuid,
                                               const QUrl& path) = 0;

public slots:
    virtual bool refreshLastOpened(const QUuid& uuid) = 0;
    virtual void setAuthenticationToken(const QString& token,
                                        const QString& email) = 0;
    virtual void clearAuthenticationToken() = 0;

signals:
    void bookCoverGenerated(int index);
    void bookInsertionStarted(int index);
    void bookInsertionEnded();
    void bookDeletionStarted(int index);
    void bookDeletionEnded();
    void tagsChanged(int index);
    void dataChanged(int index);
};

}  // namespace application
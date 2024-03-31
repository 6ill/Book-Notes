// Modal for deleting book
$(".delete-btn").on("click", function () {
    const book_title = $(this).data("title");
    const book_id = $(this).data("bookid");
    $(".modal-msg").text(`Are you sure want to delete '${book_title}'?`)
    $("#modal-delete-btn").attr("formaction", "/delete/" + book_id);
});


const maxReviewLength = 80
if ($(".review").text().length > maxReviewLength) {
    const truncatedText = $(".review").text().substring(0, maxReviewLength) + '...';
    $(".review").text(truncatedText);
}
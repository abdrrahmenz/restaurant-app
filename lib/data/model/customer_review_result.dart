import 'customer_review.dart';

class CustomerReviewResult {
    CustomerReviewResult({
        this.error,
        this.message,
        this.customerReviews,
    });

    bool error;
    String message;
    List<CustomerReview> customerReviews;

    factory CustomerReviewResult.fromJson(Map<String, dynamic> json) => CustomerReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

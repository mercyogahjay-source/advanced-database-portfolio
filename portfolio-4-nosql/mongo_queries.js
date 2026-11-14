db = db.getSiblingDB('library_reviews');

db.reviews.drop();

db.reviews.insertMany([
  {
    book: { book_id: 5, title: "Designing Data-Intensive Applications", isbn: "978-1449373320" },
    member: { member_id: 1, name: "Mercy Ogah", email: "mercy@example.com" },
    rating: 5,
    title: "Essential reading for modern engineers",
    comment: "This book fundamentally changed how I think about distributed systems.",
    tags: ["distributed-systems", "databases", "architecture"],
    helpful_votes: 12,
    verified_borrow: true,
    created_at: new Date("2026-09-20T10:30:00Z")
  },
  {
    book: { book_id: 5, title: "Designing Data-Intensive Applications", isbn: "978-1449373320" },
    member: { member_id: 4, name: "Mary Johnson", email: "mary.johnson@example.com" },
    rating: 5,
    title: "Comprehensive and practical",
    comment: "The best technical book I have read this year.",
    tags: ["architecture", "systems-design"],
    helpful_votes: 8,
    verified_borrow: true,
    created_at: new Date("2026-09-25T14:15:00Z")
  },
  {
    book: { book_id: 6, title: "NoSQL Distilled", isbn: "978-0321826268" },
    member: { member_id: 5, name: "Ahmed Hassan", email: "ahmed.hassan@example.com" },
    rating: 4,
    title: "Good introduction but slightly outdated",
    comment: "Excellent for understanding NoSQL theory.",
    tags: ["nosql", "databases"],
    helpful_votes: 5,
    verified_borrow: false,
    created_at: new Date("2026-09-28T09:00:00Z")
  },
  {
    book: { book_id: 9, title: "MongoDB: The Definitive Guide", isbn: "978-1491954461" },
    member: { member_id: 7, name: "David Kimani", email: "david.kimani@example.com" },
    rating: 5,
    title: "The MongoDB reference I keep coming back to",
    comment: "Well-organised, deep coverage, practical examples.",
    tags: ["mongodb", "nosql", "reference"],
    helpful_votes: 15,
    verified_borrow: true,
    created_at: new Date("2026-09-30T16:45:00Z")
  },
  {
    book: { book_id: 1, title: "Database System Concepts", isbn: "978-0078022159" },
    member: { member_id: 2, name: "Ada Okafor", email: "ada.okafor@example.com" },
    rating: 4,
    title: "Excellent foundation",
    comment: "Great textbook for database theory.",
    tags: ["textbook", "database-theory"],
    helpful_votes: 6,
    verified_borrow: true,
    created_at: new Date("2026-10-01T11:20:00Z")
  }
]);

print("Inserted " + db.reviews.countDocuments() + " reviews.\n");

db.reviews.createIndex({ "book.book_id": 1 });
db.reviews.createIndex({ "member.member_id": 1 });
db.reviews.createIndex({ rating: -1 });
db.reviews.createIndex({ tags: 1 });
db.reviews.createIndex({ created_at: -1 });

print("Indexes created.\n");

print("=== Q1: All reviews for Book 5 ===");
db.reviews.find(
  { "book.book_id": 5 },
  { "member.name": 1, rating: 1, title: 1, helpful_votes: 1, _id: 0 }
).forEach(printjson);

print("\n=== Q2: Average rating per book ===");
db.reviews.aggregate([
  { $group: {
      _id: "$book.book_id",
      book_title: { $first: "$book.title" },
      avg_rating: { $avg: "$rating" },
      review_count: { $sum: 1 },
      total_helpful: { $sum: "$helpful_votes" }
  } },
  { $sort: { avg_rating: -1 } }
]).forEach(printjson);

print("\n=== Q3: Reviews tagged 'nosql' ===");
db.reviews.find(
  { tags: "nosql" },
  { title: 1, "member.name": 1, rating: 1, _id: 0 }
).forEach(printjson);

print("\n=== Q4: Top 3 most helpful reviews ===");
db.reviews.find(
  {},
  { "book.title": 1, "member.name": 1, rating: 1, helpful_votes: 1, _id: 0 }
).sort({ helpful_votes: -1 }).limit(3).forEach(printjson);

print("\n=== Q5: Add helpful vote to Mercy's review ===");
db.reviews.updateOne(
  { "member.member_id": 1, "book.book_id": 5 },
  { $inc: { helpful_votes: 1 }, $set: { updated_at: new Date() } }
);
db.reviews.find(
  { "member.member_id": 1, "book.book_id": 5 },
  { title: 1, helpful_votes: 1, _id: 0 }
).forEach(printjson);

print("\n=== FINAL SUMMARY ===");
print("Total reviews: " + db.reviews.countDocuments());
print("Distinct books: " + db.reviews.distinct("book.book_id").length);
print("Distinct members: " + db.reviews.distinct("member.member_id").length);
print("All tags: " + db.reviews.distinct("tags").join(", "));

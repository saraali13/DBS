use inventoryDB

//1
db.furniture.insertMany([
    {
        name: "Table",
        color: "Brown",
        dimensions: [40, 80]
    },
    {
        name: "Chair",
        color: "Black",
        dimensions: [20, 40]
    },
    {
        name: "Sofa",
        color: "Gray",
        dimensions: [60, 120]
    }
]);

//2
db.furniture.insertOne({
    name: "Desk",
    color: "Brown",
    dimensions: [50, 100]
});

//3
db.furniture.find({
    "dimensions.0": { $gt: 30 }
});

//4
db.furniture.find({
    color: "Brown",
    name: { $in: ["Table", "Chair"] }
});

//5
db.furniture.updateOne(
    { name: "Table" },
    { $set: { color: "Ivory" } }
);

//6
db.furniture.updateMany(
    { color: "Brown" },
    { $set: { color: "Dark Brown" } }
);

//7
db.furniture.deleteOne({ name: "Chair" });

//8
db.furniture.deleteMany({
    dimensions: [12, 18]
});

//9
db.furniture.aggregate([
    {
        $group: {
            _id: "$color",
            total_items: { $sum: 1 }
        }
    }
]);

//10
db.furniture.createIndex({ name: "text" });
db.furniture.find({
    $text: { $search: "table" }
});

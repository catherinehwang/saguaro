food ||= @food

json.id food.id
json.name food.name
json.price "$%.2f" % (food.price.to_f / 100)
json.calories food.calories

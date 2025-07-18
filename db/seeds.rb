Task.destroy_all

Task.create!([
  { title: 'Buy groceries', completed: false },
  { title: 'Finish report', completed: true },
  { title: 'Clean the kitchen', completed: false },
  { title: 'Pay bills', completed: true },
  { title: 'Call Alice', completed: false }
])

puts "✅ Seeded #{Task.count} tasks."

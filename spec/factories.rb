# By using the symbol ':zombie', we get Factory Girl to simulate the Zombie model.
Factory.define :zombie do |zombie|
  zombie.name                   "Bob"
  zombie.username               "zombieBob"
  zombie.email                  "example@railsforzombies.com"
  zombie.password               "barbazquux"
  zombie.password_confirmation  "barbazquux"
end

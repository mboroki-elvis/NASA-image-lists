# NASA
### Architecture - (MVVM-C)
- Uses the coordinator pattern which abstracts routing to it's own component
- ViewModels are used for handling the business logic
### Things to improve
- For Unit tests working with schedulers to test asynchronous code never works since they run  in the background
- The workaround is to use dispatchques to fulfill the expectation after an event
- A better way would be to create AnyScheduler which would allow custom schedulers that fire immediately 
## Known bugs
- There are no known bugs at the moment

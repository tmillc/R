# traceback() - run this after error'ing on a function, prints the callstack
#   does nothing if run after no error, does nothing if another function is ran after error
# debug - flags a function for debug mode
# browser - suspends execution of a function, putting the function in debug mode
# trace - insert debugging code into a function in specific places
# recover - modify error behavior so you can browse call stack

#  Three main indications of problems: message, warning, error.
#  Only error will actually halt execution

options()$error
# (function ()
# {
#   .rs.recordTraceback(TRUE)
# })()

options(error = recover)
options()$error
# (function ()
# {
#   if (.isMethodsDispatchOn()) {
#     tState <- tracingState(FALSE)
#     on.exit(tracingState(tState))
#   }
#   calls <- sys.calls()
#  .
#  .
#  .

read.csv("nope")
#  now it puts us in a menu

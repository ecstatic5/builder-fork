local Errors = require(script.Parent.Parent.Constants.Errors)

local ChecksAndAsserts = {}

function ChecksAndAsserts.AssertType<T>(
	var: T,
	expectedType: string,
	wrongExpectedTypeError: string?,
	variableNilError: string?
)
	if wrongExpectedTypeError then
		wrongExpectedTypeError = wrongExpectedTypeError:format(typeof(var), expectedType)
	end

	assert(var, variableNilError or Errors.VAR_IS_NIL_ERROR:format(expectedType))
	assert(
		typeof(var) == expectedType,
		wrongExpectedTypeError or Errors.WRONG_TYPE_ERROR:format(typeof(var), expectedType)
	)
end

return ChecksAndAsserts

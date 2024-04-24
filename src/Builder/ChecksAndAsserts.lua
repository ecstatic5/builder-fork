local ChecksAndAsserts = {}
local DefaultErrors = {
	VarIsNil = "Passed variable is nil! Expected to be a '%s'",
	WrongExpectedTypeError = "Passed variable is a '%s'! Expected to be a '%s'",
}

function ChecksAndAsserts.AssertType<T>(
	var: T,
	expectedType: string,
	wrongExpectedTypeError: string?,
	variableNilError: string?
)
	if wrongExpectedTypeError then
		wrongExpectedTypeError = wrongExpectedTypeError:format(typeof(var), expectedType)
	end

	assert(var, variableNilError or DefaultErrors.VarIsNil:format(expectedType))
	assert(
		typeof(var) == expectedType,
		wrongExpectedTypeError
			or DefaultErrors.WrongExpectedTypeError:format(typeof(var), expectedType)
	)
end

return ChecksAndAsserts

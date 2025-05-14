module("modules.common.others.openmultiview.OpenMultiView", package.seeall)

return {
	openView = function(arg_1_0)
		local var_1_0 = FlowSequence.New()

		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			local var_1_1 = OpenViewWork.New(iter_1_1)

			var_1_0:addWork(var_1_1)
		end

		var_1_0:start()
	end
}

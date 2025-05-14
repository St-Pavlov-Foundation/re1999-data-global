module("modules.logic.rouge.controller.RougeCollectionDebugHelper", package.seeall)

local var_0_0 = _M

function var_0_0.checkCollectionStaticItmeCfgs()
	if not isDebugBuild then
		return
	end

	local var_1_0 = RougeCollectionConfig.instance:getAllItemStaticDescCfgs()

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_1 = iter_1_1.id
			local var_1_2 = tonumber(iter_1_1.item1)
			local var_1_3 = tonumber(iter_1_1.item2)
			local var_1_4 = tonumber(iter_1_1.item3)
			local var_1_5 = {
				var_1_2,
				var_1_3,
				var_1_4
			}

			RougeCollectionDescHelper.setCollectionDescInfos3(var_1_1, var_1_5)
		end
	end
end

function var_0_0.checkCollectionDescCfgs()
	if not isDebugBuild then
		return
	end

	local var_2_0 = {}
	local var_2_1 = RougeCollectionConfig.instance:getAllCollectionDescCfgs()

	if var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			local var_2_2 = iter_2_1.desc

			RougeCollectionExpressionHelper.getDescExpressionResult(var_2_2, var_2_0)
		end
	end
end

return var_0_0

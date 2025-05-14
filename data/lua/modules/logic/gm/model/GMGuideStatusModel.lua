module("modules.logic.gm.model.GMGuideStatusModel", package.seeall)

local var_0_0 = class("GMGuideStatusModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.showOpBtn = true
	arg_1_0.idReverse = false
	arg_1_0.search = ""
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._hasInit = nil
end

function var_0_0.onClickShowOpBtn(arg_3_0)
	arg_3_0.showOpBtn = not arg_3_0.showOpBtn

	arg_3_0:updateModel()
end

function var_0_0.onClickReverse(arg_4_0)
	arg_4_0.idReverse = not arg_4_0.idReverse

	arg_4_0:reInit()
	arg_4_0:updateModel()
end

function var_0_0.setSearch(arg_5_0, arg_5_1)
	arg_5_0.search = arg_5_1

	arg_5_0:reInit()
	arg_5_0:updateModel()
end

function var_0_0.getSearch(arg_6_0)
	return arg_6_0.search
end

function var_0_0.updateModel(arg_7_0)
	if not arg_7_0._hasInit then
		arg_7_0._hasInit = true

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(lua_guide.configList) do
			local var_7_1 = true

			if arg_7_0.search then
				var_7_1 = string.find(tostring(iter_7_1.id), arg_7_0.search) or string.find(iter_7_1.desc, arg_7_0.search)
			end

			if iter_7_1.isOnline == 1 and var_7_1 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		table.sort(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_0.id < arg_8_1.id
		end)

		if arg_7_0.idReverse then
			tabletool.revert(var_7_0)
		end

		arg_7_0:setList(var_7_0)
	else
		arg_7_0:onModelUpdate()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

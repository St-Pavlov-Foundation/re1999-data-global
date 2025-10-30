module("modules.logic.season.comp.SeasonStarProgressComp", package.seeall)

local var_0_0 = class("SeasonStarProgressComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.starCount = 7
end

function var_0_0.refreshStar(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:initItemList(arg_2_1)
	arg_2_0:refreshItemList(arg_2_2, arg_2_3)
end

function var_0_0.initItemList(arg_3_0, arg_3_1)
	if arg_3_0.itemList then
		return
	end

	arg_3_0.itemList = {}

	for iter_3_0 = 1, arg_3_0.starCount do
		arg_3_0.itemList[iter_3_0] = arg_3_0:createItem(iter_3_0, arg_3_1)
	end
end

function var_0_0.createItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getUserDataTb_()

	var_4_0.index = arg_4_1

	if type(arg_4_2) == "string" then
		var_4_0.go = gohelper.findChild(arg_4_0.go, string.format("%s%s", arg_4_2, arg_4_1))
	else
		var_4_0.go = gohelper.cloneInPlace(arg_4_2, string.format("star%s", arg_4_2, arg_4_1))
	end

	var_4_0.goDark = gohelper.findChild(var_4_0.go, "dark")
	var_4_0.goLight = gohelper.findChild(var_4_0.go, "light")
	var_4_0.imgDark = gohelper.findChildImage(var_4_0.go, "dark")
	var_4_0.imgLight = gohelper.findChildImage(var_4_0.go, "light")

	return var_4_0
end

function var_0_0.refreshItemList(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.itemList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList) do
			arg_5_0:updateItem(iter_5_1, arg_5_1, arg_5_2)
		end
	end
end

function var_0_0.updateItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.index
	local var_6_1 = var_6_0 == arg_6_3

	if arg_6_3 < var_6_0 or var_6_1 and arg_6_2 < var_6_0 then
		gohelper.setActive(arg_6_1.go, false)

		return
	end

	gohelper.setActive(arg_6_1.go, true)

	local var_6_2 = var_6_0 <= arg_6_2

	gohelper.setActive(arg_6_1.goLight, var_6_2)
	gohelper.setActive(arg_6_1.goDark, not var_6_2)

	if var_6_2 then
		local var_6_3 = var_6_1 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(arg_6_1.imgLight, var_6_3)
	end
end

return var_0_0

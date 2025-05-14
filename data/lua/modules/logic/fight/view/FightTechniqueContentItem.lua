module("modules.logic.fight.view.FightTechniqueContentItem", package.seeall)

local var_0_0 = class("FightTechniqueContentItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._img1 = gohelper.findChildSingleImage(arg_1_1, "#go_content/#simage_icon1")
	arg_1_0._img2 = gohelper.findChildSingleImage(arg_1_1, "#go_content/#simage_icon2")
	arg_1_0._txtBottomDesc1 = gohelper.findChildText(arg_1_1, "#txt_bottomdesc1")
	arg_1_0._txtBottomDesc2 = gohelper.findChildText(arg_1_1, "#txt_bottomdesc2")
	arg_1_0._customGODict = arg_1_0:getUserDataTb_()

	local var_1_0 = gohelper.findChild(arg_1_1, "#go_customList").transform
	local var_1_1 = var_1_0.childCount

	for iter_1_0 = 1, var_1_1 do
		local var_1_2 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_3 = tonumber(var_1_2.name)

		if var_1_3 then
			arg_1_0._customGODict[var_1_3] = var_1_2.gameObject
		end
	end
end

function var_0_0.updateItem(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1.index
	arg_2_0._id = arg_2_1.id

	transformhelper.setLocalPos(arg_2_0.go.transform, arg_2_1.pos, 0, 0)

	local var_2_0 = lua_fight_technique.configDict[arg_2_0._id]

	arg_2_0._txtBottomDesc1.text = var_2_0.content1
	arg_2_0._txtBottomDesc2.text = var_2_0.content2

	for iter_2_0, iter_2_1 in pairs(arg_2_0._customGODict) do
		gohelper.setActive(iter_2_1, arg_2_0._id == iter_2_0)
	end
end

function var_0_0.setSelect(arg_3_0, arg_3_1)
	if arg_3_0._index == arg_3_1 then
		local var_3_0 = lua_fight_technique.configDict[arg_3_0._id]

		if not string.nilorempty(var_3_0.picture1) then
			arg_3_0._img1:LoadImage(ResUrl.getFightIcon(var_3_0.picture1) .. ".png")
		end

		if not string.nilorempty(var_3_0.picture2) then
			arg_3_0._img2:LoadImage(ResUrl.getFightIcon(var_3_0.picture2) .. ".png")
		end

		gohelper.setActive(arg_3_0.go, true)
		TaskDispatcher.cancelTask(arg_3_0._hideGO, arg_3_0)
	elseif arg_3_0.go.activeInHierarchy then
		TaskDispatcher.runDelay(arg_3_0._hideGO, arg_3_0, 0.25)
	end
end

function var_0_0._hideGO(arg_4_0)
	gohelper.setActive(arg_4_0.go, false)
end

function var_0_0.onDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._hideGO, arg_5_0)

	if arg_5_0._img1 then
		arg_5_0._img1:UnLoadImage()
		arg_5_0._img2:UnLoadImage()

		arg_5_0._img1 = nil
		arg_5_0._img2 = nil
	end
end

return var_0_0

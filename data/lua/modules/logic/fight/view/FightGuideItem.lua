module("modules.logic.fight.view.FightGuideItem", package.seeall)

local var_0_0 = class("FightGuideItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_1, "#simage_icon")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_close")

	arg_1_0._btnclose:AddClickListener(arg_1_0._btncloseOnClick, arg_1_0)

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

function var_0_0._btncloseOnClick(arg_2_0)
	ViewMgr.instance:closeView(ViewName.FightGuideView)
end

function var_0_0.updateItem(arg_3_0, arg_3_1)
	arg_3_0._index = arg_3_1.index
	arg_3_0._maxIndex = arg_3_1.maxIndex
	arg_3_0._id = arg_3_1.id

	transformhelper.setLocalPos(arg_3_0.go.transform, arg_3_1.pos, 0, 0)
	arg_3_0._simagebg:LoadImage(ResUrl.getFightGuideIcon(arg_3_0._id))
	gohelper.setActive(arg_3_0._customGODict[arg_3_0._id], true)
	gohelper.setActive(arg_3_0._btnclose.gameObject, arg_3_0._maxIndex == arg_3_0._index)
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	if arg_4_0._index == arg_4_1 then
		gohelper.setActive(arg_4_0.go, true)
		TaskDispatcher.cancelTask(arg_4_0._hideGO, arg_4_0)
	elseif arg_4_0.go.activeInHierarchy then
		TaskDispatcher.runDelay(arg_4_0._hideGO, arg_4_0, 0.25)
	end
end

function var_0_0._hideGO(arg_5_0)
	gohelper.setActive(arg_5_0.go, false)
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0._btnclose:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_6_0._hideGO, arg_6_0)
	arg_6_0._simagebg:UnLoadImage()
end

return var_0_0

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLoadingView", package.seeall)

local var_0_0 = class("V1a6_CachotLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon/#simage_icon")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#simage_icon/img_en2/#txt_en")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#simage_icon/#txt_name")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not arg_6_0._rogueInfo then
		return
	end

	local var_6_0 = lua_rogue_room.configDict[arg_6_0._rogueInfo.room]

	if not var_6_0 then
		return
	end

	arg_6_0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_img_level_1"))

	arg_6_0._txten.text = var_6_0.nameEn

	local var_6_1 = var_6_0.name
	local var_6_2 = GameUtil.utf8len(var_6_1)

	if var_6_2 <= 1 then
		arg_6_0._txtname.text = string.format("<size=42>%s</size>", var_6_1)
	else
		local var_6_3 = GameUtil.utf8sub(var_6_1, 1, 1)
		local var_6_4 = GameUtil.utf8sub(var_6_1, 2, var_6_2 - 1)

		arg_6_0._txtname.text = string.format("<size=42>%s</size>%s", var_6_3, var_6_4)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_load_open)
	TaskDispatcher.runDelay(arg_6_0.checkViewIsOpenFinish, arg_6_0, 2.5)
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.V1a6_CachotMainView or arg_7_1 == ViewName.V1a6_CachotRoomView then
		TaskDispatcher.runDelay(arg_7_0.closeThis, arg_7_0, 0.2)
	end
end

function var_0_0.checkViewIsOpenFinish(arg_8_0)
	if ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotMainView) or ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotRoomView) then
		arg_8_0:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_8_0._onOpenView, arg_8_0)
	end
end

function var_0_0.onClose(arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_9_0._onOpenView, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.checkViewIsOpenFinish, arg_9_0)
	arg_9_0._simageicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLayerChangeView", package.seeall)

local var_0_0 = class("V1a6_CachotLayerChangeView", BaseView)

function var_0_0.onOpen(arg_1_0)
	arg_1_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not arg_1_0._rogueInfo then
		return
	end

	local var_1_0 = lua_rogue_room.configDict[arg_1_0._rogueInfo.room]

	if not var_1_0 then
		return
	end

	arg_1_0._gotabs = {}
	arg_1_0._difficulty = arg_1_0._rogueInfo.difficulty

	for iter_1_0 = 1, 2 do
		local var_1_1 = arg_1_0._gotabs[iter_1_0]
		local var_1_2 = var_1_0.layer

		if iter_1_0 == 1 then
			var_1_2 = var_1_2 - 1
		end

		if not var_1_1 then
			local var_1_3 = arg_1_0:getUserDataTb_()

			var_1_3.simagelevel = gohelper.findChildSingleImage(arg_1_0.viewGO, iter_1_0 .. "/#simage_level" .. iter_1_0)
			var_1_3.gohard = gohelper.findChild(arg_1_0.viewGO, iter_1_0 .. "/#go_hard")
			var_1_3.txtlevel = gohelper.findChildText(arg_1_0.viewGO, iter_1_0 .. "/#txt_level")

			table.insert(arg_1_0._gotabs, var_1_3)
			var_1_3.simagelevel:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_layerchange_level_" .. var_1_2))

			if var_1_2 >= 3 then
				gohelper.setActive(var_1_3.gohard, true)
			else
				gohelper.setActive(var_1_3.gohard, false)
			end

			var_1_3.txtlevel.text = V1a6_CachotRoomConfig.instance:getLayerName(var_1_2, arg_1_0._difficulty)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_floor_load)
	TaskDispatcher.runDelay(arg_1_0.checkViewIsOpenFinish, arg_1_0, 2.5)
end

function var_0_0._onOpenView(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.V1a6_CachotMainView or arg_2_1 == ViewName.V1a6_CachotRoomView then
		TaskDispatcher.runDelay(arg_2_0.closeThis, arg_2_0, 0.2)
	end
end

function var_0_0.checkViewIsOpenFinish(arg_3_0)
	if ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotMainView) or ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotRoomView) then
		arg_3_0:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenView, arg_3_0)
	end
end

function var_0_0.onClose(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenView, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.closeThis, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.checkViewIsOpenFinish, arg_4_0)
end

return var_0_0

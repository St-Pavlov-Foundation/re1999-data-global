module("modules.logic.survival.view.shelter.SurvivalDecreeView", package.seeall)

local var_0_0 = class("SurvivalDecreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLayout = gohelper.findChild(arg_1_0.viewGO, "#go_Leader/LayoutGroup")
	arg_1_0.layout = arg_1_0.goLayout:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_1_0.itemList = {}
	arg_1_0.goInfoRoot = gohelper.findChild(arg_1_0.viewGO, "Left/go_info")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnDecreeDataUpdate, arg_2_0.onDecreeDataUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnDecreeDataUpdate, arg_3_0.onDecreeDataUpdate, arg_3_0)
end

function var_0_0.onShelterBagUpdate(arg_4_0)
	arg_4_0:refreshInfoView()
end

function var_0_0.onBuildingInfoUpdate(arg_5_0)
	arg_5_0:refreshInfoView()
end

function var_0_0.onDecreeDataUpdate(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	arg_7_0:refreshView()
	arg_7_0:playOpenAnim()
end

function var_0_0.refreshView(arg_8_0)
	local var_8_0 = arg_8_0:getItemCount()

	for iter_8_0 = 1, var_8_0 do
		arg_8_0:getItem(iter_8_0):updateItem(iter_8_0)
	end

	arg_8_0:refreshInfoView()
end

function var_0_0.getItemCount(arg_9_0)
	local var_9_0 = 2
	local var_9_1 = 0
	local var_9_2 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)

	if var_9_2 then
		for iter_9_0 = var_9_0, 1, -1 do
			if SurvivalConfig.instance:getBuildingConfig(var_9_2.buildingId, iter_9_0, true) then
				var_9_1 = iter_9_0

				break
			end
		end
	end

	return var_9_1
end

function var_0_0.getItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.itemList[arg_10_1]

	if not var_10_0 then
		local var_10_1 = arg_10_0.viewContainer:getResInst(arg_10_0.viewContainer:getSetting().otherRes.itemRes, arg_10_0.goLayout, tostring(arg_10_1))

		var_10_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, SurvivalDecreeItem)
		arg_10_0.itemList[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.playOpenAnim(arg_11_0)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0.goLayout.transform)

	arg_11_0.layout.enabled = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList) do
		gohelper.setActive(iter_11_1.viewGO, false)
	end

	arg_11_0._animIndex = 0

	TaskDispatcher.runRepeat(arg_11_0._playItemOpenAnim, arg_11_0, 0.1, #arg_11_0.itemList)
end

function var_0_0._playItemOpenAnim(arg_12_0)
	arg_12_0._animIndex = arg_12_0._animIndex + 1

	local var_12_0 = arg_12_0.itemList[arg_12_0._animIndex]

	if var_12_0 then
		gohelper.setActive(var_12_0.viewGO, true)
	end

	if arg_12_0._animIndex >= #arg_12_0.itemList then
		TaskDispatcher.cancelTask(arg_12_0._playItemOpenAnim, arg_12_0)
		TaskDispatcher.runDelay(arg_12_0.playSwitchAnim, arg_12_0, 0.4)
	end
end

function var_0_0.playSwitchAnim(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.itemList) do
		iter_13_1:playSwitchAnim()
	end
end

function var_0_0.refreshInfoView(arg_14_0)
	local var_14_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)

	if not arg_14_0.infoView then
		local var_14_1 = arg_14_0.viewContainer:getRes(arg_14_0.viewContainer:getSetting().otherRes.infoView)

		arg_14_0.infoView = ShelterManagerInfoView.getView(var_14_1, arg_14_0.goInfoRoot, "infoView")
	end

	local var_14_2 = {
		showType = SurvivalEnum.InfoShowType.Building,
		showId = var_14_0 and var_14_0.id or 0
	}

	arg_14_0.infoView:refreshParam(var_14_2)
end

function var_0_0.onClose(arg_15_0)
	if PopupController.instance:isPause() then
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function var_0_0.onDestroyView(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.playSwitchAnim, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._playItemOpenAnim, arg_16_0)
end

return var_0_0

module("modules.logic.survival.view.shelter.ShelterRestManagerView", package.seeall)

local var_0_0 = class("ShelterRestManagerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnclose")
	arg_1_0.goRight = gohelper.findChild(arg_1_0.viewGO, "Panel/Right")
	arg_1_0.txtRest = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Right/#go_Rest/Title/Layout/txt_Rest")
	arg_1_0.txtMember = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Right/#go_Rest/Title/Layout/#txt_MemberNum")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
end

function var_0_0.onClickClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onBuildingInfoUpdate(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onClickGridItem(arg_6_0, arg_6_1)
	if not arg_6_1.data then
		return
	end

	if SurvivalShelterNpcListModel.instance:setSelectNpcId(arg_6_1.data.id) then
		arg_6_0:refreshView()
	end
end

function var_0_0._dropHealthHero(arg_7_0)
	SurvivalShelterRestListModel.instance:dropHealthHero(arg_7_0.buildingInfo)
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
	UIBlockHelper.instance:startBlock(arg_8_0.viewName, 0.4, arg_8_0.viewName)
	TaskDispatcher.runDelay(arg_8_0._dropHealthHero, arg_8_0, 0.4)
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.buildingId = arg_9_0.viewParam.buildingId
	arg_9_0.buildingInfo = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_9_0.buildingId)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnOpenBuildingView, arg_9_0.buildingInfo:getBuildingType())
end

function var_0_0.refreshView(arg_10_0)
	if not arg_10_0.buildingInfo then
		return
	end

	arg_10_0:refreshList()
	arg_10_0:refreshInfoView()
end

function var_0_0.refreshList(arg_11_0)
	if arg_11_0.buildingInfo.level == 0 or not arg_11_0.buildingInfo:isEqualType(SurvivalEnum.BuildingType.Health) then
		gohelper.setActive(arg_11_0.goRight, false)

		return
	end

	gohelper.setActive(arg_11_0.goRight, true)
	SurvivalShelterRestListModel.instance:refreshList(arg_11_0.buildingInfo)

	arg_11_0.txtRest.text = arg_11_0.buildingInfo.baseCo.name

	local var_11_0 = tabletool.len(arg_11_0.buildingInfo.heros)
	local var_11_1 = arg_11_0.buildingInfo:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)

	arg_11_0.txtMember.text = string.format("%s/%s", var_11_0, var_11_1)
end

function var_0_0.refreshInfoView(arg_12_0)
	if not arg_12_0.infoView then
		local var_12_0 = arg_12_0.viewContainer:getRes(arg_12_0.viewContainer:getSetting().otherRes.infoView)
		local var_12_1 = gohelper.findChild(arg_12_0.viewGO, "Panel/go_manageinfo")

		arg_12_0.infoView = ShelterManagerInfoView.getView(var_12_0, var_12_1, "infoView")
	end

	local var_12_2 = {
		showType = SurvivalEnum.InfoShowType.Building,
		showId = arg_12_0.buildingId
	}

	arg_12_0.infoView:refreshParam(var_12_2)
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._dropHealthHero, arg_13_0)
end

return var_0_0

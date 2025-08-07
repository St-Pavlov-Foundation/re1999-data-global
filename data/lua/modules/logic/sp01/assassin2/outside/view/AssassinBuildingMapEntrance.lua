module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingMapEntrance", package.seeall)

local var_0_0 = class("AssassinBuildingMapEntrance", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golevelup = gohelper.findChild(arg_1_0.viewGO, "go_levelup")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateBuildingInfo, arg_2_0.refresh, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_2_0.refresh, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_2_0.refresh, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UnlockBuildings, arg_2_0.refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0, arg_4_1)
	if AssassinOutsideModel.instance:getBuildingMapMo() then
		AssassinController.instance:openAssassinBuildingMapView({
			buildingType = arg_4_1
		})
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refresh()

	local var_6_0 = arg_6_0.viewContainer.viewParam

	if var_6_0 and var_6_0.openBuildingMap then
		arg_6_0:_btnclickOnClick(var_6_0.buildingType)
	end
end

function var_0_0.refresh(arg_7_0)
	arg_7_0:refreshCanLevelUp()
end

function var_0_0.refreshCanLevelUp(arg_8_0)
	local var_8_0 = AssassinOutsideModel.instance:getBuildingMapMo()
	local var_8_1 = var_8_0 and var_8_0:isAnyBuildingLevelUp2NextLv()

	gohelper.setActive(arg_8_0._golevelup, var_8_1)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

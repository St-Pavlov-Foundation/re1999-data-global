module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpView", package.seeall)

local var_0_0 = class("AssassinBuildingLevelUpView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/left/image_namebg/#txt_name")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_lv")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_list/Viewport/Content")
	arg_1_0._golistitem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_list/Viewport/Content/#go_listitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateBuildingInfo, arg_2_0._onUpdateBuildingInfo, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UnlockBuildings, arg_2_0._onUnlockBuildings, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnLevelUpBuilding, arg_2_0._onLevelUpBuilding, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AssassinBuildingLevelUpListModel.instance:markNeedPlayOpenAnimItemCount(AssassinEnum.NeedPlayOpenAnimBuildingCount)

	arg_7_0._buildingType = arg_7_0.viewParam and arg_7_0.viewParam.buildingType

	arg_7_0:openSubView(AssassinCurrencyToolView, nil, arg_7_0._gotopright)
	arg_7_0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0._buildingMo = AssassinOutsideModel.instance:getBuildingMo(arg_8_0._buildingType)
	arg_8_0._config = arg_8_0._buildingMo:getConfig()
	arg_8_0._txtname.text = arg_8_0._config.title
	arg_8_0._lv = arg_8_0._buildingMo:getLv()
	arg_8_0._txtlv.text = AssassinHelper.formatLv(arg_8_0._lv)

	arg_8_0:refreshListItemList()
end

function var_0_0.refreshListItemList(arg_9_0)
	AssassinBuildingLevelUpListModel.instance:init(arg_9_0._buildingType)

	local var_9_0 = AssassinBuildingLevelUpListModel.instance:getList()

	gohelper.CreateObjList(arg_9_0, arg_9_0.refreshLevelUpItem, var_9_0, arg_9_0._gocontent, arg_9_0._golistitem, AssassinBuildingLevelUpListItem)
end

function var_0_0.refreshLevelUpItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1:onUpdateMO(arg_10_2, arg_10_3)
end

function var_0_0._onUpdateBuildingInfo(arg_11_0)
	arg_11_0:refresh()
end

function var_0_0._onUnlockBuildings(arg_12_0)
	arg_12_0:refresh()
end

function var_0_0._onLevelUpBuilding(arg_13_0)
	arg_13_0._animator:Play("leveup", 0, 0)
end

function var_0_0.onClose(arg_14_0)
	AssassinController.instance:dispatchEvent(AssassinEvent.FocusBuilding, arg_14_0._buildingType, false)
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0

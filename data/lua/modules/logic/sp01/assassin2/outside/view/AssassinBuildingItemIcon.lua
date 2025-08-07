module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingItemIcon", package.seeall)

local var_0_0 = class("AssassinBuildingItemIcon", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.go, "simage_icon")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.go, "go_unlock")
	arg_1_0._simageiconline = gohelper.findChildSingleImage(arg_1_0.go, "go_unlock/simage_icon_line")
	arg_1_0._simageiconline2 = gohelper.findChildSingleImage(arg_1_0.go, "go_unlock/simage_icon_line/glow")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.go, "go_unlock/txt_name")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.go, "go_unlock/txt_lv")
	arg_1_0._golevelup = gohelper.findChild(arg_1_0.go, "go_unlock/go_levelup")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gobuildingclickarea = gohelper.findChild(arg_1_0.go, "btn_click/go_buildingclickarea")
	arg_1_0._animator = gohelper.onceAddComponent(arg_1_0.go, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateBuildingInfo, arg_2_0._onUpdateBuildingInfo, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UnlockBuildings, arg_2_0._onUnlockBuildings, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.FocusBuilding, arg_2_0._onFocusBuilding, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_2_0._onUpdateCoinNum, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._isUnlocked then
		return
	end

	AssassinController.instance:dispatchEvent(AssassinEvent.FocusBuilding, arg_4_0._type, true)
	AssassinController.instance:openAssassinBuildingLevelUpView(arg_4_0._type)
end

function var_0_0.setBuildingType(arg_5_0, arg_5_1)
	arg_5_0._type = arg_5_1

	arg_5_0:refresh()
end

function var_0_0.updateIconPosition(arg_6_0, arg_6_1)
	if gohelper.isNil(arg_6_1) then
		return
	end

	local var_6_0, var_6_1 = recthelper.getAnchor(arg_6_1.transform)

	recthelper.setAnchor(arg_6_0._simageicon.transform, var_6_0 or 0, var_6_1 or 0)
	recthelper.setAnchor(arg_6_0._simageiconline.transform, var_6_0 or 0, var_6_1 or 0)
end

function var_0_0.updateIconClickArea(arg_7_0, arg_7_1)
	if gohelper.isNil(arg_7_1) then
		return
	end

	local var_7_0 = arg_7_1.transform
	local var_7_1, var_7_2 = recthelper.getAnchor(var_7_0)
	local var_7_3 = recthelper.getWidth(var_7_0)
	local var_7_4 = recthelper.getHeight(var_7_0)

	recthelper.setAnchor(arg_7_0._gobuildingclickarea.transform, var_7_1, var_7_2)
	recthelper.setSize(arg_7_0._gobuildingclickarea.transform, var_7_3, var_7_4)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0._mapMo = AssassinOutsideModel.instance:getBuildingMapMo()
	arg_8_0._isUnlocked = arg_8_0._mapMo and arg_8_0._mapMo:isBuildingTypeUnlocked(arg_8_0._type)

	gohelper.setActive(arg_8_0.go, true)
	gohelper.setActive(arg_8_0._gounlock, arg_8_0._isUnlocked)

	if not arg_8_0._isUnlocked then
		local var_8_0 = AssassinConfig.instance:getBuildingLvCo(arg_8_0._type, 1)

		arg_8_0._simageicon:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. var_8_0.lockBuildingIcon))

		return
	end

	local var_8_1 = arg_8_0._mapMo:getBuildingMo(arg_8_0._type)
	local var_8_2 = var_8_1 and var_8_1:getConfig()

	arg_8_0._lv = var_8_1 and var_8_1:getLv()
	arg_8_0._txtname.text = var_8_2 and var_8_2.title or ""
	arg_8_0._txtlv.text = AssassinHelper.formatLv(arg_8_0._lv)

	local var_8_3 = arg_8_0._mapMo:isBuildingLevelUp2NextLv(arg_8_0._type)

	gohelper.setActive(arg_8_0._golevelup, var_8_3)
	arg_8_0._simageicon:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. var_8_2.buildingIcon))
	arg_8_0._simageiconline:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. var_8_2.buildingBgIcon))
	arg_8_0._simageiconline2:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. var_8_2.buildingBgIcon))
end

function var_0_0._onUpdateBuildingInfo(arg_9_0, arg_9_1)
	if arg_9_0._type ~= arg_9_1 then
		return
	end

	arg_9_0:refresh()
end

function var_0_0._onUnlockBuildings(arg_10_0)
	arg_10_0:refresh()
end

function var_0_0._onFocusBuilding(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 and "switch" or "bake"

	arg_11_0._animator:Play(var_11_0, 0, 0)
end

function var_0_0._onUpdateCoinNum(arg_12_0)
	arg_12_0:refresh()
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._simageicon:UnLoadImage()
	arg_13_0._simageiconline:UnLoadImage()
	arg_13_0._simageiconline2:UnLoadImage()
end

return var_0_0

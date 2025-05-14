module("modules.ugui.icon.common.CommonCritterIcon", package.seeall)

local var_0_0 = class("CommonCritterIcon", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "#simage_quality")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._gomood = gohelper.findChild(arg_1_0.viewGO, "#go_mood")
	arg_1_0._gobuildingIcon = gohelper.findChild(arg_1_0.viewGO, "#go_buildingIcon")
	arg_1_0._imagebuildingIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_buildingIcon/#simage_buildingIcon")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._gomaturity = gohelper.findChild(arg_1_0.viewGO, "#go_manufacture")
	arg_1_0._goindex = gohelper.findChild(arg_1_0.viewGO, "#go_index")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_index/#txt_index")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._gouptips = gohelper.findChild(arg_1_0.viewGO, "#go_uptips")
	arg_1_0._gospecial = gohelper.findChild(arg_1_0.viewGO, "#go_special")

	arg_1_0:setSelectUIVisible()
	arg_1_0:showIndex()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0.mo and arg_4_0.mo.uid then
		SLFramework.SLLogger.Log("魔精uid:" .. arg_4_0.mo.uid)
	end

	if arg_4_0._customCallback then
		return arg_4_0._customCallback(arg_4_0._customCallbackObj, arg_4_0._customClickParams)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.trans = arg_5_0.viewGO.transform

	arg_5_0:hideMood()
end

function var_0_0.getCritterMo(arg_6_0, arg_6_1)
	if not arg_6_0.mo and arg_6_1 then
		logError(string.format("CommonCritterIcon:getCritterMo error, no critterMo, uid:%s", arg_6_0.critterUid))
	end

	return arg_6_0.mo
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.mo = arg_7_1
	arg_7_0.critterUid = arg_7_0.mo:getId()
	arg_7_0.critterId = arg_7_0.mo:getDefineId()

	arg_7_0:refresh()
end

function var_0_0.setMOValue(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.critterUid = arg_8_1
	arg_8_0.critterId = arg_8_2
	arg_8_0.mo = CritterModel.instance:getCritterMOByUid(arg_8_0.critterUid)

	if arg_8_0.mo and not arg_8_0.critterId then
		arg_8_0.critterId = arg_8_0.mo:getDefineId()
	end

	arg_8_0:refresh()
end

function var_0_0.setSelectUIVisible(arg_9_0, arg_9_1)
	arg_9_0._isShowSelectedUI = arg_9_1

	arg_9_0:onSelect()

	if arg_9_0._isShowSelectedUI then
		CritterController.instance:dispatchEvent(CritterEvent.CheckCritterIconSelected, arg_9_0.critterUid, arg_9_0.critterId)
	end
end

function var_0_0.setIsShowBuildingIcon(arg_10_0, arg_10_1)
	arg_10_0._isShowBuildingIcon = arg_10_1

	arg_10_0:refreshBuildingIcon()
end

function var_0_0.setCanClick(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._btnclick.gameObject, arg_11_1)
end

function var_0_0.setCustomClick(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._customCallback = arg_12_1
	arg_12_0._customCallbackObj = arg_12_2
	arg_12_0._customClickParams = arg_12_3
end

function var_0_0.setLockIconShow(arg_13_0, arg_13_1)
	arg_13_0._isShowLockIcon = arg_13_1

	arg_13_0:refreshLockIcon()
end

function var_0_0.setMaturityIconShow(arg_14_0, arg_14_1)
	arg_14_0._isShowMaturityIcon = arg_14_1

	arg_14_0:refreshMaturityIcon()
end

function var_0_0.refresh(arg_15_0)
	arg_15_0:refreshIcon()
	arg_15_0:refreshRare()
	arg_15_0:refreshBuildingIcon()
	arg_15_0:refreshLockIcon()
	arg_15_0:refreshMaturityIcon()
end

function var_0_0.refreshIcon(arg_16_0)
	local var_16_0
	local var_16_1 = arg_16_0:getCritterMo()

	if var_16_1 then
		var_16_0 = var_16_1:getSkinId()
	else
		var_16_0 = CritterConfig.instance:getCritterNormalSkin(arg_16_0.critterId)
	end

	local var_16_2 = CritterConfig.instance:getCritterHeadIcon(var_16_0)

	if not string.nilorempty(var_16_2) then
		local var_16_3 = ResUrl.getCritterHedaIcon(var_16_2)

		arg_16_0:_loadIcon(var_16_3)
	end
end

function var_0_0._loadIcon(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	arg_17_0._simageicon:LoadImage(arg_17_1)
end

function var_0_0.refreshRare(arg_18_0)
	local var_18_0 = CritterConfig.instance:getCritterRare(arg_18_0.critterId)

	if var_18_0 then
		UISpriteSetMgr.instance:setCritterSprite(arg_18_0._imagequality, CritterEnum.QualityImageNameMap[var_18_0])
	end
end

function var_0_0.showMood(arg_19_0)
	if not arg_19_0._moodItem then
		arg_19_0._moodItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_19_0._gomood, CritterMoodItem)
	end

	arg_19_0._moodItem:setCritterUid(arg_19_0.critterUid)
	gohelper.setActive(arg_19_0._gomood, true)
end

function var_0_0.hideMood(arg_20_0)
	gohelper.setActive(arg_20_0._gomood, false)
end

function var_0_0.showUpTip(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._gouptips, arg_21_1)
end

function var_0_0.showSpeical(arg_22_0)
	local var_22_0 = arg_22_0:getCritterMo():isMutate()

	gohelper.setActive(arg_22_0._gospecial, var_22_0)
end

function var_0_0.refreshBuildingIcon(arg_23_0)
	gohelper.setActive(arg_23_0._gobuildingIcon, false)

	if not arg_23_0._isShowBuildingIcon then
		return
	end

	local var_23_0
	local var_23_1 = ManufactureModel.instance:getCritterWorkingBuilding(arg_23_0.critterUid) or ManufactureModel.instance:getCritterRestingBuilding(arg_23_0.critterUid)
	local var_23_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_23_1)

	if var_23_2 then
		var_23_0 = ManufactureConfig.instance:getManufactureBuildingIcon(var_23_2.buildingId)
	end

	if not var_23_0 then
		local var_23_3 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(arg_23_0.critterUid)

		if var_23_3 then
			local var_23_4 = var_23_3.buildingId
			local var_23_5 = var_23_3.buildingSkinId
			local var_23_6 = RoomTransportHelper.getVehicleCfgByBuildingId(var_23_4, var_23_5)

			var_23_0 = var_23_6 and var_23_6.buildIcon
		end
	end

	if not var_23_0 and arg_23_0.mo:isCultivating() then
		var_23_0 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CultivatingIcon)
	end

	if var_23_0 then
		UISpriteSetMgr.instance:setRoomSprite(arg_23_0._imagebuildingIcon, var_23_0)
		gohelper.setActive(arg_23_0._gobuildingIcon, true)
	end
end

function var_0_0.refreshLockIcon(arg_24_0)
	local var_24_0 = false

	if arg_24_0._isShowLockIcon and arg_24_0.mo then
		var_24_0 = arg_24_0.mo:isLock()
	end

	gohelper.setActive(arg_24_0._golocked, var_24_0)
end

function var_0_0.refreshMaturityIcon(arg_25_0)
	local var_25_0 = false

	if arg_25_0._isShowMaturityIcon and arg_25_0.mo then
		var_25_0 = arg_25_0.mo:isMaturity()
	end

	gohelper.setActive(arg_25_0._gomaturity, var_25_0)
end

function var_0_0.onSelect(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._goselected, arg_26_0._isShowSelectedUI and arg_26_1)
end

function var_0_0.showIndex(arg_27_0, arg_27_1)
	if arg_27_1 then
		arg_27_0._txtindex.text = arg_27_1
	end

	gohelper.setActive(arg_27_0._goindex, arg_27_1)
end

function var_0_0.onDestroyView(arg_28_0)
	if arg_28_0._simageicon then
		arg_28_0._simageicon:UnLoadImage()

		arg_28_0._simageicon = nil
	end
end

return var_0_0

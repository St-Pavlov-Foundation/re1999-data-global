module("modules.logic.room.view.manufacture.RoomManufactureCritterItem", package.seeall)

local var_0_0 = class("RoomManufactureCritterItem", ListScrollCellExtend)
local var_0_1 = 0.5
local var_0_2 = 99999

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_name")
	arg_1_0._imageskill = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_skill/#image_skill")
	arg_1_0._gosimageskill = arg_1_0._imageskill.gameObject
	arg_1_0._txtefficiency = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_layoutAttr/#go_efficiency/#txt_efficiency")
	arg_1_0._txtmoodcostspeed = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_layoutAttr/#go_moodCostSpeed/#txt_moodCostSpeed")
	arg_1_0._txtcrirate = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_layoutAttr/#go_criRate/#txt_criRate")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._gohighQuality = gohelper.findChild(arg_1_0.viewGO, "#go_highQuality")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goskillTabLayout = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_skillTabLayout")
	arg_1_0._goskillTabItem = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_skillTabLayout/#go_skillTabItem")
	arg_1_0._btnlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._btnclick.gameObject)

	arg_1_0._btnlongPrees:SetLongPressTime({
		var_0_1,
		var_0_2
	})

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnlongPrees:AddLongPressListener(arg_2_0._onLongPress, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, arg_2_0._onCritterWorkInfoChange, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, arg_2_0._onCritterWorkInfoChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_2_0._onAttrPreviewUpdate, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, arg_2_0._onCritterRenameReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnlongPrees:RemoveLongPressListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, arg_3_0._onCritterWorkInfoChange, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, arg_3_0._onCritterWorkInfoChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_3_0._onAttrPreviewUpdate, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterRenameReply, arg_3_0._onCritterRenameReply, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = arg_4_0:getCritterId()

	if arg_4_0:getPathId() then
		ManufactureController.instance:clickTransportCritterItem(var_4_0)
	else
		ManufactureController.instance:clickCritterItem(var_4_0)
	end
end

function var_0_0._onLongPress(arg_5_0)
	local var_5_0 = arg_5_0._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not var_5_0, arg_5_0._mo)
end

function var_0_0._onCritterWorkInfoChange(arg_6_0)
	arg_6_0:refreshSelected()
end

function var_0_0._onAttrPreviewUpdate(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getCritterId()

	if var_7_0 and not arg_7_1[var_7_0] then
		return
	end

	arg_7_0:refreshPreviewAttr()
	arg_7_0:refreshPreviewSkill()
end

function var_0_0._onCritterRenameReply(arg_8_0, arg_8_1)
	if arg_8_0:getCritterId() == arg_8_1 then
		arg_8_0:setCritter()
	end
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._goskillTabItem, false)
end

function var_0_0.getViewBuilding(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = arg_10_0._view.viewContainer:getContainerViewBuilding()

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.getPathId(arg_11_0)
	return arg_11_0._view.viewContainer:getContainerPathId()
end

function var_0_0.getCritterId(arg_12_0)
	local var_12_0
	local var_12_1

	if arg_12_0._mo then
		var_12_0 = arg_12_0._mo:getId()
		var_12_1 = arg_12_0._mo:getDefineId()
	end

	return var_12_0, var_12_1
end

function var_0_0.getPreviewAttrInfo(arg_13_0)
	local var_13_0 = arg_13_0:getCritterId()
	local var_13_1 = true
	local var_13_2

	if not arg_13_0:getPathId() then
		local var_13_3, var_13_4, var_13_5 = arg_13_0:getViewBuilding()

		if var_13_4 and var_13_4:isCritterInSeatSlot(var_13_0) then
			var_13_2 = var_13_5
			var_13_1 = false
		end
	end

	return ManufactureCritterListModel.instance:getPreviewAttrInfo(var_13_0, var_13_2, var_13_1)
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._mo = arg_14_1

	arg_14_0:setCritter()
	arg_14_0:refresh()

	local var_14_0, var_14_1, var_14_2 = arg_14_0:getViewBuilding()

	CritterController.instance:getNextCritterPreviewAttr(var_14_2, arg_14_0._index)
end

function var_0_0.setCritter(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:getCritterId()

	if not arg_15_0.critterIcon then
		arg_15_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_15_0._goicon)
	end

	arg_15_0.critterIcon:setMOValue(var_15_0, var_15_1)
	arg_15_0.critterIcon:showMood()

	arg_15_0._txtname.text = arg_15_0._mo and arg_15_0._mo:getName() or CritterConfig.instance:getCritterName(var_15_1)

	local var_15_2 = arg_15_0._mo and arg_15_0._mo:getSkillInfo()

	if var_15_2 then
		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			local var_15_3 = CritterConfig.instance:getCritterTagCfg(iter_15_1)

			if var_15_3 and var_15_3.type == CritterEnum.TagType.Race then
				UISpriteSetMgr.instance:setCritterSprite(arg_15_0._imageskill, var_15_3.skillIcon)

				break
			end
		end
	end

	local var_15_4 = arg_15_0._mo:getIsHighQuality()

	gohelper.setActive(arg_15_0._gohighQuality, var_15_4)
end

function var_0_0.refresh(arg_16_0)
	arg_16_0:refreshSelected()
	arg_16_0:refreshPreviewAttr()
	arg_16_0:refreshPreviewSkill()
end

function var_0_0.refreshSelected(arg_17_0)
	if not arg_17_0.critterIcon then
		return
	end

	local var_17_0 = false
	local var_17_1 = arg_17_0:getCritterId()
	local var_17_2 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_17_1)
	local var_17_3 = var_17_2 and var_17_2.id
	local var_17_4 = ManufactureModel.instance:getCritterWorkingBuilding(var_17_1)
	local var_17_5 = arg_17_0:getPathId()

	if var_17_5 then
		var_17_0 = var_17_3 == var_17_5
	else
		var_17_0 = arg_17_0:getViewBuilding() == var_17_4
	end

	local var_17_6 = (var_17_3 or var_17_4) and not var_17_0

	arg_17_0.critterIcon:setIsShowBuildingIcon(var_17_6)
	gohelper.setActive(arg_17_0._goselected, var_17_0)
end

function var_0_0.refreshPreviewAttr(arg_18_0)
	local var_18_0 = arg_18_0:getPreviewAttrInfo()

	ZProj.UGUIHelper.SetGrayscale(arg_18_0._gosimageskill, not var_18_0.isSpSkillEffect)

	arg_18_0._txtefficiency.text = var_18_0.efficiency or 0
	arg_18_0._txtmoodcostspeed.text = GameUtil.getSubPlaceholderLuaLang(luaLang("critter_mood_cost_speed"), {
		var_18_0.moodCostSpeed or 0
	})
	arg_18_0._txtcrirate.text = string.format("%s%%", var_18_0.criRate or 0)
end

function var_0_0.refreshPreviewSkill(arg_19_0)
	arg_19_0._skillTbList = arg_19_0._skillTbList or {}

	local var_19_0 = arg_19_0._mo and arg_19_0._mo:getSkillInfo()
	local var_19_1 = 0

	if var_19_0 then
		local var_19_2 = arg_19_0:getPreviewAttrInfo()

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			local var_19_3 = CritterConfig.instance:getCritterTagCfg(iter_19_1)

			if var_19_3 and var_19_3.type == CritterEnum.SkilTagType.Common then
				var_19_1 = var_19_1 + 1

				local var_19_4 = arg_19_0._skillTbList[var_19_1]

				if not var_19_4 then
					local var_19_5 = gohelper.cloneInPlace(arg_19_0._goskillTabItem)

					var_19_4 = arg_19_0:getUserDataTb_()
					var_19_4.go = var_19_5
					var_19_4.skillIcon = gohelper.findChildImage(var_19_5, "image_skillIcon")
					var_19_4.goskillIcon = var_19_4.skillIcon.gameObject
					arg_19_0._skillTbList[var_19_1] = var_19_4
				end

				UISpriteSetMgr.instance:setCritterSprite(var_19_4.skillIcon, var_19_3.skillIcon)

				local var_19_6 = true

				if var_19_2 and var_19_2.skillTags and tabletool.indexOf(var_19_2.skillTags, var_19_3.id) then
					var_19_6 = false
				end

				ZProj.UGUIHelper.SetGrayscale(var_19_4.goskillIcon, var_19_6)
			end
		end
	end

	for iter_19_2 = 1, #arg_19_0._skillTbList do
		gohelper.setActive(arg_19_0._skillTbList[iter_19_2].go, iter_19_2 <= var_19_1)
	end
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0

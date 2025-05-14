module("modules.logic.critter.view.CritterMoodItem", package.seeall)

local var_0_0 = class("CritterMoodItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gohasMood = gohelper.findChild(arg_1_0.go, "#go_hasMood")
	arg_1_0._imagemood = gohelper.findChildImage(arg_1_0.go, "#go_hasMood/#simage_mood")
	arg_1_0._imagemoodvalue = gohelper.findChildImage(arg_1_0.go, "#go_hasMood/#simage_progress")
	arg_1_0._txtMoodValue = gohelper.findChildText(arg_1_0.go, "#go_hasMood/#txt_mood")
	arg_1_0._gonoMood = gohelper.findChild(arg_1_0.go, "#go_noMood")
	arg_1_0._txtmoodRestore = gohelper.findChildText(arg_1_0.go, "#txt_moodRestore")
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._txtmoodRestore then
		gohelper.setActive(arg_1_0._txtmoodRestore, false)

		arg_1_0._txtmoodRestore.text = ""
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterFeedFood, arg_2_0._onFeedFood, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_2_0._onMoodChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_2_0._onAttrPreviewUpdate, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterFeedFood, arg_3_0._onFeedFood, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_3_0._onMoodChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_3_0._onAttrPreviewUpdate, arg_3_0)
end

function var_0_0._onFeedFood(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.critterUid or arg_4_1 and not arg_4_1[arg_4_0.critterUid] then
		return
	end

	if arg_4_0._animator then
		arg_4_0._animator:Play(arg_4_2 and "love" or "like", 0, 0)
	end

	arg_4_0:refreshMood()
end

function var_0_0._onMoodChange(arg_5_0, arg_5_1)
	if not arg_5_0.critterUid or arg_5_1 and not arg_5_1[arg_5_0.critterUid] then
		return
	end

	arg_5_0:refreshMood()
end

function var_0_0._onAttrPreviewUpdate(arg_6_0, arg_6_1)
	arg_6_0:_onMoodChange(arg_6_1)
end

function var_0_0.setCritterUid(arg_7_0, arg_7_1)
	arg_7_0.critterUid = arg_7_1

	arg_7_0:refreshMood()
end

function var_0_0.setShowMoodRestore(arg_8_0, arg_8_1)
	arg_8_0._isNOShowRestore = arg_8_1 == false

	gohelper.setActive(arg_8_0._txtmoodRestore, arg_8_1 ~= false)
end

function var_0_0.refreshMood(arg_9_0)
	if not arg_9_0.critterUid then
		logError("CritterMoodItem:refreshMood error,critterUid is nil")

		return
	end

	local var_9_0 = 0
	local var_9_1 = CritterModel.instance:getCritterMOByUid(arg_9_0.critterUid)

	if var_9_1 then
		var_9_0 = var_9_1:getMoodValue()
	end

	local var_9_2 = var_9_0 ~= 0

	gohelper.setActive(arg_9_0._gohasMood, var_9_2)
	gohelper.setActive(arg_9_0._gonoMood, not var_9_2)

	if var_9_2 then
		local var_9_3 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
		local var_9_4 = tonumber(var_9_3) or 0
		local var_9_5 = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.LowMood) or 0
		local var_9_6 = var_9_0 <= tonumber(var_9_5)
		local var_9_7 = "critter_manufacture_heart1"

		if var_9_6 then
			var_9_7 = "critter_manufacture_heart2"
		end

		UISpriteSetMgr.instance:setCritterSprite(arg_9_0._imagemood, var_9_7)
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._imagemoodvalue, var_9_6 and "#B76D79" or "#FDB467")

		arg_9_0._txtMoodValue.text = var_9_0

		local var_9_8 = 0

		if var_9_0 and var_9_4 and var_9_4 ~= 0 then
			var_9_8 = Mathf.Clamp(var_9_0 / var_9_4, 0, 1)
		end

		arg_9_0._imagemoodvalue.fillAmount = var_9_8
	end

	if arg_9_0._isNOShowRestore ~= true and arg_9_0._txtmoodRestore then
		local var_9_9 = CritterHelper.getPreViewAttrValue(CritterEnum.AttributeType.MoodRestore, arg_9_0.critterUid)

		arg_9_0._txtmoodRestore.text = "+" .. CritterHelper.formatAttrValue(CritterEnum.AttributeType.MoodRestore, var_9_9)

		gohelper.setActive(arg_9_0._txtmoodRestore, var_9_9 > 0)

		local var_9_10 = CritterHelper.getPatienceChangeValue(RoomBuildingEnum.BuildingType.Rest)

		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtmoodRestore, var_9_10 < var_9_9 and "#D9A06F" or "#D4C399")
	end
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0

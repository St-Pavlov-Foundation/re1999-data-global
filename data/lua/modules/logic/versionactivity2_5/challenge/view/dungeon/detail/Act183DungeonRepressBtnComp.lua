module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRepressBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonRepressBtnComp", Act183DungeonBaseComp)
local var_0_1 = 25
local var_0_2 = 0

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btnrepress = gohelper.getClickWithDefaultAudio(arg_1_0.go)
	arg_1_0._txtbtnrepress = gohelper.findChildText(arg_1_0.go, "txt_Cn")
	arg_1_0._gosetrepresshero = gohelper.findChild(arg_1_0.go, "#go_setrepresshero")
	arg_1_0._simagerepressheroicon = gohelper.findChildSingleImage(arg_1_0.go, "#go_setrepresshero/#simage_repressheroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.go, "#go_setrepresshero/#image_Career")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateBadgeDetailVisible, arg_2_0._onUpdateBadgeDetailVisible, arg_2_0)
	arg_2_0._btnrepress:AddClickListener(arg_2_0._btnrepressOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnrepress:RemoveClickListener()
end

function var_0_0._btnrepressOnClick(arg_4_0)
	local var_4_0 = {
		activityId = arg_4_0._activityId,
		episodeMo = arg_4_0._episodeMo
	}

	Act183Controller.instance:openAct183RepressView(var_4_0)
end

function var_0_0.updateInfo(arg_5_0, arg_5_1)
	var_0_0.super.updateInfo(arg_5_0, arg_5_1)

	arg_5_0._isCanReRepress = arg_5_0._groupEpisodeMo:isEpisodeCanReRepress(arg_5_0._episodeId)
end

function var_0_0.checkIsVisible(arg_6_0)
	return arg_6_0._isCanReRepress
end

function var_0_0.show(arg_7_0)
	var_0_0.super.show(arg_7_0)

	local var_7_0 = arg_7_0._episodeMo:getRepressHeroMo()
	local var_7_1 = var_7_0 ~= nil

	gohelper.setActive(arg_7_0._gosetrepresshero, var_7_1)

	local var_7_2 = var_7_1 and var_0_1 or var_0_2

	recthelper.setAnchorX(arg_7_0._txtbtnrepress.transform, var_7_2)

	if not var_7_1 then
		return
	end

	local var_7_3 = var_7_0:getHeroIconUrl()

	arg_7_0._simagerepressheroicon:LoadImage(var_7_3)

	local var_7_4 = var_7_0:getHeroCarrer()

	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer, "lssx_" .. tostring(var_7_4))
end

function var_0_0._onUpdateBadgeDetailVisible(arg_8_0, arg_8_1)
	if arg_8_0:checkIsVisible() then
		gohelper.setActive(arg_8_0.go, not arg_8_1)
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._simagerepressheroicon:UnLoadImage()
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0

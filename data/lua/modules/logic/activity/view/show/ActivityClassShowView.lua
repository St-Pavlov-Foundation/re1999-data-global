module("modules.logic.activity.view.show.ActivityClassShowView", package.seeall)

local var_0_0 = class("ActivityClassShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_desc")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
end

var_0_0.ShowCount = 1
var_0_0.unlimitDay = 42

function var_0_0._btnjumpOnClick(arg_4_0)
	local var_4_0 = DungeonModel.instance:getLastEpisodeShowData()

	if not var_4_0 then
		return
	end

	if TeachNoteModel.instance:isTeachNoteUnlock() then
		local var_4_1 = {}
		local var_4_2 = var_4_0.id
		local var_4_3 = var_4_0.chapterId

		var_4_1.chapterType = lua_chapter.configDict[var_4_3].type
		var_4_1.chapterId = var_4_3
		var_4_1.episodeId = var_4_2

		TeachNoteModel.instance:setJumpEnter(false)
		DungeonController.instance:jumpDungeon(var_4_1)
	else
		GameFacade.showToast(ToastEnum.ClassShow)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_class_bg"))
	gohelper.setActive(arg_5_0._gorewarditem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	arg_7_0._actId = arg_7_0.viewParam.actId

	gohelper.addChild(var_7_0, arg_7_0.viewGO)

	arg_7_0._rewardItems = arg_7_0:getUserDataTb_()

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0._config = ActivityConfig.instance:getActivityShowTaskList(arg_8_0._actId, 1)
	arg_8_0._txtdesc.text = arg_8_0._config.actDesc

	local var_8_0, var_8_1 = ActivityModel.instance:getRemainTime(arg_8_0._actId)

	arg_8_0._txttime.text = var_8_0 > var_0_0.unlimitDay and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), var_8_0, var_8_1)

	local var_8_2 = string.split(arg_8_0._config.showBonus, "|")

	for iter_8_0 = 1, #var_8_2 do
		if not arg_8_0._rewardItems[iter_8_0] then
			local var_8_3 = arg_8_0:getUserDataTb_()

			var_8_3.go = gohelper.clone(arg_8_0._gorewarditem, arg_8_0._gorewardContent, "rewarditem" .. iter_8_0)
			var_8_3.item = IconMgr.instance:getCommonPropItemIcon(var_8_3.go)

			table.insert(arg_8_0._rewardItems, var_8_3)
		end

		gohelper.setActive(arg_8_0._rewardItems[iter_8_0].go, true)

		local var_8_4 = string.splitToNumber(var_8_2[iter_8_0], "#")

		arg_8_0._rewardItems[iter_8_0].item:setMOValue(var_8_4[1], var_8_4[2], var_8_4[3])
		arg_8_0._rewardItems[iter_8_0].item:isShowCount(var_8_4[4] == var_0_0.ShowCount)
		arg_8_0._rewardItems[iter_8_0].item:setCountFontSize(56)
		arg_8_0._rewardItems[iter_8_0].item:setHideLvAndBreakFlag(true)
		arg_8_0._rewardItems[iter_8_0].item:hideEquipLvAndBreak(true)
	end

	for iter_8_1 = #var_8_2 + 1, #arg_8_0._rewardItems do
		gohelper.setActive(arg_8_0._rewardItems[iter_8_1].go, false)
	end
end

function var_0_0._onOpenViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.DungeonMapView then
		TeachNoteController.instance:enterTeachNoteView(nil, false)
		ViewMgr.instance:closeView(ViewName.ActivityWelfareView, true)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0

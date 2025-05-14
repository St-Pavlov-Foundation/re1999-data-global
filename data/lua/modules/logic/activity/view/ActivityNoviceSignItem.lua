module("modules.logic.activity.view.ActivityNoviceSignItem", package.seeall)

local var_0_0 = class("ActivityNoviceSignItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._gobg = gohelper.findChild(arg_1_1, "#go_normalday/normalbg")
	arg_1_0._gotomorrowtag = gohelper.findChild(arg_1_1, "#go_tomorrowtag")
	arg_1_0._gotodaynormalbg = gohelper.findChild(arg_1_1, "#go_todaynormalbg")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_1, "date/datecn")
	arg_1_0._gonormalday = gohelper.findChild(arg_1_1, "#go_normalday")
	arg_1_0._gonormalget = gohelper.findChild(arg_1_1, "#go_normalget")
	arg_1_0._finalget = gohelper.findChild(arg_1_1, "#go_finalget")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0._gotodaynormalbg)
	arg_1_0._gofinalbg = gohelper.findChild(arg_1_1, "#go_finalday/finalbg")
	arg_1_0._finalitemClick = gohelper.getClickWithAudio(arg_1_0._gofinalbg)
	arg_1_0._siamgefinalrewardicon = gohelper.findChildSingleImage(arg_1_1, "#go_finalday/#siamge_finalrewardicon")
	arg_1_0._gofinalday = gohelper.findChild(arg_1_1, "#go_finalday")
	arg_1_0._goicon1 = gohelper.findChild(arg_1_1, "#go_normalday/content/#go_icon1")
	arg_1_0._goicon2 = gohelper.findChild(arg_1_1, "#go_normalday/content/#go_icon2")
	arg_1_0._canvascontent = gohelper.findChild(arg_1_1, "#go_normalday/content"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._canvasdate = gohelper.findChild(arg_1_1, "date"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._anim.enabled = false

	gohelper.setActive(arg_1_1, false)

	arg_1_0._rewardTab = {}
end

var_0_0.finalday = 8

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	arg_2_0._finalitemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
	arg_3_0._finalitemClick:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	local var_4_0 = ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, arg_4_0._index)
	local var_4_1 = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign)

	if var_4_0 then
		Activity101Rpc.instance:sendGet101BonusRequest(ActivityEnum.Activity.NoviceSign, arg_4_0._index)
	end

	if arg_4_0._index == var_0_0.finalday and not var_4_0 then
		MaterialTipController.instance:showMaterialInfo(tonumber(arg_4_0._prop[1]), tonumber(arg_4_0._prop[2]))
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshItem()
	TaskDispatcher.runDelay(arg_5_0._playAnimation, arg_5_0, arg_5_0._index * 0.03)
end

function var_0_0._refreshItem(arg_6_0)
	ActivityType101Model.instance:setCurIndex(arg_6_0._index)

	if arg_6_0._index ~= var_0_0.finalday then
		local var_6_0 = string.split(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, arg_6_0._index).bonus, "|")

		for iter_6_0 = 1, #var_6_0 do
			local var_6_1 = string.splitToNumber(var_6_0[iter_6_0], "#")
			local var_6_2 = arg_6_0._rewardTab[iter_6_0]

			if not var_6_2 then
				var_6_2 = IconMgr.instance:getCommonPropItemIcon(arg_6_0["_goicon" .. iter_6_0])

				table.insert(arg_6_0._rewardTab, var_6_2)
			end

			var_6_2:setMOValue(var_6_1[1], var_6_1[2], var_6_1[3])
			var_6_2:setCountFontSize(46)
			var_6_2:setHideLvAndBreakFlag(true)
			var_6_2:hideEquipLvAndBreak(true)
		end

		SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._txtdate, "#ADA697")
	else
		arg_6_0._prop = string.splitToNumber(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, arg_6_0._index).bonus, "#")

		local var_6_3, var_6_4 = ItemModel.instance:getItemConfigAndIcon(arg_6_0._prop[1], arg_6_0._prop[2], true)

		arg_6_0._siamgefinalrewardicon:LoadImage(var_6_4)
		SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._txtdate, "#B57F50")
	end

	gohelper.setActive(arg_6_0._gofinalday, tonumber(arg_6_0._index) == var_0_0.finalday)
	gohelper.setActive(arg_6_0._gonormalday, tonumber(arg_6_0._index) ~= var_0_0.finalday)

	arg_6_0._txtdate.text = string.format("%02d", arg_6_0._index)

	local var_6_5 = ActivityType101Model.instance:isType101RewardGet(ActivityEnum.Activity.NoviceSign, arg_6_0._index)
	local var_6_6 = ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, arg_6_0._index)
	local var_6_7 = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign)

	gohelper.setActive(arg_6_0._gonormalget, var_6_5 and arg_6_0._index ~= var_0_0.finalday)
	gohelper.setActive(arg_6_0._finalget, var_6_5 and arg_6_0._index == var_0_0.finalday)
	gohelper.setActive(arg_6_0._gotodaynormalbg, var_6_6)
	gohelper.setActive(arg_6_0._gotomorrowtag, arg_6_0._index == var_6_7 + 1)

	arg_6_0._canvascontent.alpha = var_6_5 and 0.8 or 1
	arg_6_0._canvasdate.alpha = var_6_5 and 0.8 or 1

	ZProj.UGUIHelper.SetColorAlpha(arg_6_0._siamgefinalrewardicon:GetComponent(gohelper.Type_Image), var_6_5 and 0.8 or 1)
end

function var_0_0._playAnimation(arg_7_0)
	gohelper.setActive(arg_7_0._go, true)

	arg_7_0._anim.enabled = true
end

function var_0_0.onDestroy(arg_8_0)
	if arg_8_0._index and tonumber(arg_8_0._index) == 8 then
		arg_8_0._siamgefinalrewardicon:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_8_0._playAnimation, arg_8_0)
end

return var_0_0

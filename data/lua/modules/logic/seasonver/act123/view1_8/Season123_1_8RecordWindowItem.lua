module("modules.logic.seasonver.act123.view1_8.Season123_1_8RecordWindowItem", package.seeall)

local var_0_0 = class("Season123_1_8RecordWindowItem", LuaCompBase)
local var_0_1 = 6

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gobestrecord = gohelper.findChild(arg_1_0.go, "#go_bestrecord")
	arg_1_0._gonormalrecord = gohelper.findChild(arg_1_0.go, "#go_normalrecord")
	arg_1_0._txtTotalEn = gohelper.findChildText(arg_1_0.go, "#go_normalrecord/en1")
	arg_1_0._goBestBg = gohelper.findChild(arg_1_0.go, "#go_normalrecord/totaltime/#img_bestBg")
	arg_1_0._goBestCircle = gohelper.findChild(arg_1_0.go, "#go_normalrecord/totaltime/#go_bestcircle")
	arg_1_0._txtBlueTxtTime = gohelper.findChildText(arg_1_0.go, "#go_normalrecord/totaltime/#go_bestcircle/#txt_timeblue")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.go, "#go_normalrecord/totaltime/#txt_time")
	arg_1_0._btndetails = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_normalrecord/#btn_details")
	arg_1_0._transHeroList = gohelper.findChild(arg_1_0.go, "#go_normalrecord/#scroll_herolist").transform
	arg_1_0._originalHeroListY = recthelper.getAnchorY(arg_1_0._transHeroList)
	arg_1_0._goContent = gohelper.findChild(arg_1_0.go, "#go_normalrecord/#scroll_herolist/Viewport/Content")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.go, "#go_normalrecord/#scroll_herolist/Viewport/Content/#go_heroitem")
	arg_1_0._itemAni = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btndetails:AddClickListener(arg_2_0._btndetailsOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btndetails:RemoveClickListener()
end

function var_0_0._btndetailsOnClick(arg_4_0)
	if not arg_4_0.mo or not arg_4_0.mo.attackStatistics then
		return
	end

	FightStatModel.instance:setAtkStatInfo(arg_4_0.mo.attackStatistics)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0.onLoad(arg_5_0, arg_5_1, arg_5_2)
	gohelper.setActive(arg_5_0.go, false)

	arg_5_0._isPlayOpen = arg_5_2

	TaskDispatcher.runDelay(arg_5_0._delayActive, arg_5_0, arg_5_1)
end

function var_0_0._delayActive(arg_6_0)
	gohelper.setActive(arg_6_0.go, true)
	arg_6_0:playAnimation(arg_6_0._isPlayOpen and UIAnimationName.Open or UIAnimationName.Idle)

	arg_6_0._isPlayOpen = false
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.mo = arg_7_1

	if not arg_7_0.mo or arg_7_0.mo.isEmpty then
		gohelper.setActive(arg_7_0._gobestrecord, false)
		gohelper.setActive(arg_7_0._gonormalrecord, false)

		return
	end

	gohelper.setActive(arg_7_0._gonormalrecord, true)

	local var_7_0 = arg_7_0.mo.round or 0
	local var_7_1 = arg_7_0.mo.isBest
	local var_7_2 = arg_7_0.mo.heroList or {}

	arg_7_0._txttime.text = var_7_0
	arg_7_0._txtBlueTxtTime.text = var_7_0

	gohelper.setActive(arg_7_0._gobestrecord, var_7_1)
	gohelper.setActive(arg_7_0._goBestBg, var_7_1)
	gohelper.setActive(arg_7_0._goBestCircle, var_7_1)

	local var_7_3 = var_7_1 and "#7D4A29" or "#393939"

	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtTotalEn, var_7_3)

	local var_7_4 = var_7_1 and arg_7_0._originalHeroListY or arg_7_0._originalHeroListY + var_0_1

	recthelper.setAnchorY(arg_7_0._transHeroList, var_7_4)
	gohelper.CreateObjList(arg_7_0, arg_7_0._onHeroItemLoad, var_7_2, arg_7_0._goContent, arg_7_0._goheroitem)
end

function var_0_0.playAnimation(arg_8_0, arg_8_1)
	if not arg_8_0._itemAni then
		return
	end

	arg_8_0._itemAni:Play(arg_8_1 or UIAnimationName.Idle)
end

function var_0_0._onHeroItemLoad(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if gohelper.isNil(arg_9_1) then
		return
	end

	local var_9_0 = gohelper.findChild(arg_9_1, "empty")
	local var_9_1 = gohelper.findChild(arg_9_1, "assist")
	local var_9_2 = gohelper.findChild(arg_9_1, "hero")
	local var_9_3
	local var_9_4
	local var_9_5 = arg_9_2.heroId

	if var_9_5 and var_9_5 ~= 0 then
		var_9_3 = HeroConfig.instance:getHeroCO(var_9_5)
	end

	if not gohelper.isNil(var_9_2) then
		var_9_4 = IconMgr.instance:getCommonHeroIconNew(var_9_2)
	end

	if var_9_3 and var_9_4 then
		local var_9_6 = arg_9_2.level or 1
		local var_9_7 = arg_9_2.skinId or var_9_3.skinId
		local var_9_8 = arg_9_2.isBalance
		local var_9_9 = arg_9_2.isAssist
		local var_9_10 = HeroMo.New()

		var_9_10:initFromConfig(var_9_3)

		local var_9_11, var_9_12 = HeroConfig.instance:getShowLevel(var_9_6)

		var_9_10.rank = var_9_12
		var_9_10.level = var_9_6
		var_9_10.skin = var_9_7

		var_9_4:onUpdateMO(var_9_10)
		var_9_4:isShowRare(false)
		var_9_4:isShowEmptyWhenNoneHero(false)
		var_9_4:setIsBalance(var_9_8)
		gohelper.setActive(var_9_2, true)
		gohelper.setActive(var_9_1, var_9_9)
		gohelper.setActive(var_9_0, false)
	else
		gohelper.setActive(var_9_2, false)
		gohelper.setActive(var_9_1, false)
		gohelper.setActive(var_9_0, true)
	end
end

function var_0_0.onDestroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayActive, arg_10_0)

	arg_10_0._isPlayOpen = false
end

return var_0_0

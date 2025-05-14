module("modules.logic.rouge.dlc.101.view.RougeLimiterView", package.seeall)

local var_0_0 = class("RougeLimiterView", BaseView)

var_0_0.DefaultBackgroundImageName = "rouge_dlc1_fullbg1"

local var_0_1 = {
	Locked2Unlocked = "light",
	Unlocked = "idle",
	Locked = "idlegray"
}
local var_0_2 = {
	"idle",
	"1to2",
	"2to3",
	"3to4",
	Default = "idle",
	[5] = "4to5"
}
local var_0_3 = {
	Positive = 1,
	Reverse = -1
}
local var_0_4 = {
	[var_0_3.Positive] = 0,
	[var_0_3.Reverse] = 1
}
local var_0_5 = {
	[var_0_2[1]] = AudioEnum.UI.LimiterStageChanged_1,
	[var_0_2[2]] = AudioEnum.UI.LimiterStageChanged_2,
	[var_0_2[3]] = AudioEnum.UI.LimiterStageChanged_3,
	[var_0_2[4]] = AudioEnum.UI.LimiterStageChanged_4,
	[var_0_2[5]] = AudioEnum.UI.LimiterStageChanged_5
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobuffdec = gohelper.findChild(arg_1_0.viewGO, "#go_buffdec")
	arg_1_0._gochoosebuff = gohelper.findChild(arg_1_0.viewGO, "#go_choosebuff")
	arg_1_0._gosmallbuffitem = gohelper.findChild(arg_1_0.viewGO, "#go_choosebuff/SmallBuffView/Viewport/Content/#go_smallbuffitem")
	arg_1_0._golimiteritem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_limiteritem")
	arg_1_0._goRightTop = gohelper.findChild(arg_1_0.viewGO, "#go_RightTop")
	arg_1_0._txtpoint = gohelper.findChildText(arg_1_0.viewGO, "#go_RightTop/point/#txt_point")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_RightTop/point/#btn_click")
	arg_1_0._goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_LeftTop")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_RightTop/#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	local var_4_0 = RougeDLCModel101.instance:getSelectLimiterGroupIds()

	if not var_4_0 or #var_4_0 <= 0 then
		return
	end

	RougeDLCModel101.instance:resetAllSelectLimitIds()
	RougeDLCController101.instance:openRougeLimiterView()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.addUIClickAudio(arg_5_0._btnreset.gameObject, AudioEnum.UI.ResetRougeLimiter)
	arg_5_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, arg_5_0._onUpdateLimiterGroup, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseViewCallBack, arg_5_0)

	arg_5_0._godifficultybg = gohelper.findChild(arg_5_0.viewGO, "difficulty_bg")
	arg_5_0._bgAnimator = gohelper.onceAddComponent(arg_5_0._godifficultybg, gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:onInit()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:onInit()
end

function var_0_0.onInit(arg_8_0)
	arg_8_0:initDebuffs()
	arg_8_0:initBuffEntry()
	arg_8_0:refreshBackGroundBg()
end

function var_0_0.initDebuffs(arg_9_0)
	local var_9_0 = RougeModel.instance:getVersion()
	local var_9_1 = RougeDLCConfig101.instance:getAllVersionLimiterGroupCos(var_9_0)

	if var_9_1 then
		arg_9_0:initBuffIcons(var_9_1)
		arg_9_0:initLines(var_9_1)
	end

	RougeDLCModel101.instance:resetLimiterGroupNewUnlockInfo()
end

function var_0_0.initBuffIcons(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		arg_10_0:_getOrCreatelimiterGroupItem(iter_10_1.id):onUpdateMO(iter_10_1)
	end
end

function var_0_0.refreshBackGroundBg(arg_11_0)
	local var_11_0 = RougeDLCModel101.instance:getTotalRiskValue()
	local var_11_1 = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(var_11_0)

	if arg_11_0._riskCo == var_11_1 then
		return
	end

	local var_11_2, var_11_3, var_11_4 = arg_11_0:getTargetBgAnimStateInfo(arg_11_0._riskCo, var_11_1)

	arg_11_0._bgAnimator:SetFloat("speed", var_11_3)
	arg_11_0._bgAnimator:Play(var_11_2, 0, var_11_4)

	local var_11_5 = var_0_5[var_11_2]

	if var_11_5 then
		AudioMgr.instance:trigger(var_11_5)
	end

	arg_11_0._riskCo = var_11_1
end

function var_0_0.getTargetBgAnimStateInfo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = RougeDLCHelper101.isLimiterRisker(arg_12_1, arg_12_2)
	local var_12_1 = RougeDLCHelper101.isNearLimiter(arg_12_1, arg_12_2)
	local var_12_2 = ""
	local var_12_3

	if var_12_0 or not var_12_1 then
		local var_12_4 = arg_12_2 and arg_12_2.id or 0

		var_12_2 = var_0_2[var_12_4] or var_0_2.Default
		var_12_3 = var_0_3.Positive
	else
		local var_12_5 = arg_12_1 and arg_12_1.id or 0

		var_12_2 = var_0_2[var_12_5] or var_0_2.Default
		var_12_3 = var_0_3.Reverse
	end

	local var_12_6 = var_0_4[var_12_3]

	return var_12_2, var_12_3, var_12_6
end

function var_0_0._getOrCreatelimiterGroupItem(arg_13_0, arg_13_1)
	arg_13_0._limiterGroupItemTab = arg_13_0._limiterGroupItemTab or arg_13_0:getUserDataTb_()

	local var_13_0 = arg_13_0._limiterGroupItemTab[arg_13_1]

	if not var_13_0 then
		local var_13_1 = "Left/BuffView/Viewport/Content/" .. arg_13_1
		local var_13_2 = gohelper.findChild(arg_13_0.viewGO, var_13_1)

		if gohelper.isNil(var_13_2) then
			local var_13_3 = gohelper.findChild(arg_13_0.viewGO, "Left/BuffView/Viewport/Content")

			var_13_2 = gohelper.create2d(var_13_3, arg_13_1)

			logError("无法找到指定的限制器组挂点,已创建临时节点代替。挂点路径:" .. var_13_1)
		end

		local var_13_4 = arg_13_0.viewContainer:getSetting().otherRes.LimiterGroupItem
		local var_13_5 = arg_13_0:getResInst(var_13_4, var_13_2, "debuffitem_" .. arg_13_1)

		var_13_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_5, RougeLimiterGroupItem)
		arg_13_0._limiterGroupItemTab[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.initLines(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_0:initUnlockMap(arg_14_1)

	for iter_14_0, iter_14_1 in pairs(arg_14_0._unlockMap) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			local var_14_0 = RougeDLCModel101.instance:getCurLimiterGroupState(iter_14_2) == RougeDLCEnum101.LimitState.Unlocked
			local var_14_1 = gohelper.findChild(arg_14_0.viewGO, string.format("Left/BuffView/Viewport/Content/%s_%s", iter_14_0, iter_14_2))

			if not gohelper.isNil(var_14_1) then
				gohelper.setActive(var_14_1, true)

				local var_14_2 = var_0_1.Locked

				if var_14_0 then
					var_14_2 = RougeDLCModel101.instance:isLimiterGroupNewUnlocked(iter_14_2) and var_0_1.Locked2Unlocked or var_0_1.Unlocked
				end

				gohelper.onceAddComponent(var_14_1, gohelper.Type_Animator):Play(var_14_2, 0, 0)
			else
				logError(string.format("缺少限制器连接线:%s ---> %s", iter_14_0, iter_14_2))
			end
		end
	end
end

function var_0_0.initUnlockMap(arg_15_0, arg_15_1)
	arg_15_0._unlockMap = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = iter_15_1.unlockCondition
		local var_15_1, var_15_2 = string.match(var_15_0, "^(.*):(.+)$")
		local var_15_3 = string.splitToNumber(var_15_2, "#")

		if var_15_3 then
			for iter_15_2, iter_15_3 in ipairs(var_15_3) do
				arg_15_0._unlockMap[iter_15_3] = arg_15_0._unlockMap[iter_15_3] or {}
				arg_15_0._unlockMap[iter_15_3][iter_15_1.id] = true
			end
		end
	end
end

function var_0_0.initBuffEntry(arg_16_0)
	if not arg_16_0._buffEntry then
		local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes.LimiterItem

		arg_16_0._gobufficon = arg_16_0:getResInst(var_16_0, arg_16_0._golimiteritem, "#go_bufficon")
		arg_16_0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(arg_16_0._gobufficon, RougeLimiterBuffEntry)
	end

	arg_16_0._buffEntry:refreshUI(true)
end

function var_0_0._onUpdateLimiterGroup(arg_17_0)
	arg_17_0:refreshBackGroundBg()
end

function var_0_0._onCloseViewCallBack(arg_18_0, arg_18_1)
	if arg_18_0._buffEntry then
		arg_18_0._buffEntry:selectBuffEntry()
	end
end

function var_0_0.onClose(arg_19_0)
	RougeDLCController101.instance:try2SaveLimiterSetting()
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0

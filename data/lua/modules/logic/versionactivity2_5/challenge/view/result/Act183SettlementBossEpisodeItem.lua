module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementBossEpisodeItem", package.seeall)

local var_0_0 = class("Act183SettlementBossEpisodeItem", LuaCompBase)
local var_0_1 = {
	"v2a5_challenge_result_roundbg4",
	"v2a5_challenge_result_roundbg3",
	"v2a5_challenge_result_roundbg2",
	"v2a5_challenge_result_roundbg1"
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtbossbadge = gohelper.findChildText(arg_1_1, "root/right/#txt_bossbadge")
	arg_1_0._simageboss = gohelper.findChildSingleImage(arg_1_1, "root/right/#simage_boss")
	arg_1_0._gobossheros = gohelper.findChild(arg_1_1, "root/right/#go_bossheros")
	arg_1_0._gostars = gohelper.findChild(arg_1_1, "root/right/BossStars/#go_Stars")
	arg_1_0._gostaritem = gohelper.findChild(arg_1_1, "root/right/BossStars/#go_Stars/#go_Staritem")
	arg_1_0._txtround = gohelper.findChildText(arg_1_1, "root/right/totalround/#txt_totalround")
	arg_1_0._imageroundbg = gohelper.findChildImage(arg_1_1, "root/right/totalround/#image_roundbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._herogroupComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gobossheros, Act183SettlementBossEpisodeHeroComp)
end

function var_0_0.setHeroTemplate(arg_5_0, arg_5_1)
	if arg_5_0._herogroupComp then
		arg_5_0._herogroupComp:setHeroTemplate(arg_5_1)
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		return
	end

	arg_6_0._bossEpisodeId = arg_6_2:getEpisodeId()

	Act183Helper.setBossEpisodeResultIcon(arg_6_0._bossEpisodeId, arg_6_0._simageboss)
	arg_6_0:refreshRound(arg_6_2)
	arg_6_0:refreshUseBadge(arg_6_2)
	arg_6_0:refreshHeroGroup(arg_6_2)
	arg_6_0:refreshEpisodeStars(arg_6_2)
end

function var_0_0.refreshUseBadge(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getUseBadgeNum()

	gohelper.setActive(arg_7_0._txtbossbadge.gameObject, var_7_0 > 0)

	arg_7_0._txtbossbadge.text = var_7_0
end

function var_0_0.refreshEpisodeStars(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getTotalStarCount()
	local var_8_1 = arg_8_1:getFinishStarCount()

	for iter_8_0 = 1, var_8_0 do
		local var_8_2 = gohelper.cloneInPlace(arg_8_0._gostaritem, "star_" .. iter_8_0)
		local var_8_3 = gohelper.onceAddComponent(var_8_2, gohelper.Type_Image)
		local var_8_4 = iter_8_0 <= var_8_1 and "#F77040" or "#87898C"

		UISpriteSetMgr.instance:setCommonSprite(var_8_3, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(var_8_3, var_8_4)
		gohelper.setActive(var_8_2, true)
	end
end

function var_0_0.refreshHeroGroup(arg_9_0, arg_9_1)
	if arg_9_0._herogroupComp then
		arg_9_0._herogroupComp:onUpdateMO(arg_9_1)
	end
end

function var_0_0.refreshRound(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getRound()

	arg_10_0._txtround.text = var_10_0

	local var_10_1 = Act183Helper.getRoundStage(var_10_0)
	local var_10_2 = var_0_1[var_10_1]

	if var_10_2 then
		UISpriteSetMgr.instance:setChallengeSprite(arg_10_0._imageroundbg, var_10_2)
	else
		logError(string.format("缺少回合数挡位 --> 回合数背景图配置 roundNum = %s, stage = %s", var_10_0, var_10_1))
	end
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0

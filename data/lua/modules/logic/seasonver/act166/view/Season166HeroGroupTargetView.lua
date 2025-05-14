module("modules.logic.seasonver.act166.view.Season166HeroGroupTargetView", package.seeall)

local var_0_0 = class("Season166HeroGroupTargetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gotargetScoreContent = gohelper.findChild(arg_1_0.viewGO, "bg/targetScore/#go_targetScoreContent")
	arg_1_0._gotargetItem = gohelper.findChild(arg_1_0.viewGO, "bg/targetScore/#go_targetScoreContent/#go_targetItem")
	arg_1_0._gotargetContent = gohelper.findChild(arg_1_0.viewGO, "bg/#go_targetContent")
	arg_1_0._godescItem = gohelper.findChild(arg_1_0.viewGO, "bg/#go_targetContent/#go_descItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId
	arg_7_0.baseId = arg_7_0.viewParam.baseId

	arg_7_0:createScoreItem()
	arg_7_0:createTargetDescItem()
end

function var_0_0.createScoreItem(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, 3 do
		local var_8_1 = Season166Config.instance:getSeasonScoreCo(arg_8_0.actId, iter_8_0)

		table.insert(var_8_0, var_8_1)
	end

	gohelper.CreateObjList(arg_8_0, arg_8_0.scoreItemShow, var_8_0, arg_8_0._gotargetScoreContent, arg_8_0._gotargetItem)
end

function var_0_0.scoreItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildText(arg_9_1, "txt_target")
	local var_9_1 = gohelper.findChild(arg_9_1, "go_star/go_starIcon")

	gohelper.setActive(var_9_1, false)

	var_9_0.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_targetscore"), {
		arg_9_2.needScore
	})

	local var_9_2 = arg_9_2.star

	for iter_9_0 = 1, var_9_2 do
		local var_9_3 = gohelper.cloneInPlace(var_9_1)

		gohelper.setActive(var_9_3, true)
	end
end

function var_0_0.createTargetDescItem(arg_10_0)
	local var_10_0 = Season166Config.instance:getSeasonBaseTargetCos(arg_10_0.actId, arg_10_0.baseId)

	gohelper.CreateObjList(arg_10_0, arg_10_0.targetDescItemShow, var_10_0, arg_10_0._gotargetContent, arg_10_0._godescItem)
end

function var_0_0.targetDescItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	gohelper.findChildText(arg_11_1, "txt_desc").text = arg_11_2.targetDesc
end

function var_0_0.onClose(arg_12_0)
	Season166HeroGroupController.instance:dispatchEvent(Season166Event.CloseHeroGroupTargetView)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

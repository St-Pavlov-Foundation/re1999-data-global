module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipView", package.seeall)

local var_0_0 = class("YaXianGameTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_block")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._txtrecommondlevel = gohelper.findChildText(arg_1_0.viewGO, "rotate/desc_container/recommond/#txt_recommondlevel")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/desc_container/scroll_desc/Viewport/Content/#txt_info")
	arg_1_0._goop = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op/#btn_back")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op/#btn_fight")
	arg_1_0._simagedesccontainer = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/desc_container")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
end

function var_0_0._btnblockOnClick(arg_4_0)
	arg_4_0:fallBack()
end

function var_0_0._btnbackOnClick(arg_5_0)
	arg_5_0:fallBack()
end

function var_0_0._btnfightOnClick(arg_6_0)
	YaXianDungeonController.instance:enterFight(arg_6_0.battleId)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, arg_7_0.closeThis, arg_7_0)
	arg_7_0._simagedesccontainer:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.interactId = arg_9_0.viewParam.interactId
	arg_9_0.interactCo = YaXianConfig.instance:getInteractObjectCo(YaXianEnum.ActivityId, arg_9_0.interactId)
	arg_9_0.battleId = tonumber(arg_9_0.interactCo.param)

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._txttitle.text = arg_10_0.interactCo.battleName
	arg_10_0._txtrecommondlevel.text = HeroConfig.instance:getCommonLevelDisplay(arg_10_0.interactCo.recommendLevel)
	arg_10_0._txtinfo.text = arg_10_0.interactCo.battleDesc
end

function var_0_0.fallBack(arg_11_0)
	Activity115Rpc.instance:sendAct115RevertRequest(YaXianGameModel.instance:getActId())
	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	local var_12_0 = YaXianGameController.instance.state

	if var_12_0 then
		var_12_0:disposeEventState()
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnStateFinish, YaXianGameEnum.GameStateType.Battle)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagedesccontainer:UnLoadImage()
end

return var_0_0

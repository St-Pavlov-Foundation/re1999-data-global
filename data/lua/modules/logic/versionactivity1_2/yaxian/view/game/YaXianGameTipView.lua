module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipView", package.seeall)

slot0 = class("YaXianGameTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_block")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/layout/top/title/#txt_title")
	slot0._txtrecommondlevel = gohelper.findChildText(slot0.viewGO, "rotate/desc_container/recommond/#txt_recommondlevel")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "rotate/desc_container/scroll_desc/Viewport/Content/#txt_info")
	slot0._goop = gohelper.findChild(slot0.viewGO, "rotate/#go_op")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op/#btn_back")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op/#btn_fight")
	slot0._simagedesccontainer = gohelper.findChildSingleImage(slot0.viewGO, "rotate/desc_container")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
end

function slot0._btnblockOnClick(slot0)
	slot0:fallBack()
end

function slot0._btnbackOnClick(slot0)
	slot0:fallBack()
end

function slot0._btnfightOnClick(slot0)
	YaXianDungeonController.instance:enterFight(slot0.battleId)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, slot0.closeThis, slot0)
	slot0._simagedesccontainer:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.interactId = slot0.viewParam.interactId
	slot0.interactCo = YaXianConfig.instance:getInteractObjectCo(YaXianEnum.ActivityId, slot0.interactId)
	slot0.battleId = tonumber(slot0.interactCo.param)

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txttitle.text = slot0.interactCo.battleName
	slot0._txtrecommondlevel.text = HeroConfig.instance:getCommonLevelDisplay(slot0.interactCo.recommendLevel)
	slot0._txtinfo.text = slot0.interactCo.battleDesc
end

function slot0.fallBack(slot0)
	Activity115Rpc.instance:sendAct115RevertRequest(YaXianGameModel.instance:getActId())
	slot0:closeThis()
end

function slot0.onClose(slot0)
	if YaXianGameController.instance.state then
		slot1:disposeEventState()
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnStateFinish, YaXianGameEnum.GameStateType.Battle)
end

function slot0.onDestroyView(slot0)
	slot0._simagedesccontainer:UnLoadImage()
end

return slot0

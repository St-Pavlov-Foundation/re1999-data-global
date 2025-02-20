module("modules.logic.seasonver.act166.view.Season166HeroGroupTargetView", package.seeall)

slot0 = class("Season166HeroGroupTargetView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gotargetScoreContent = gohelper.findChild(slot0.viewGO, "bg/targetScore/#go_targetScoreContent")
	slot0._gotargetItem = gohelper.findChild(slot0.viewGO, "bg/targetScore/#go_targetScoreContent/#go_targetItem")
	slot0._gotargetContent = gohelper.findChild(slot0.viewGO, "bg/#go_targetContent")
	slot0._godescItem = gohelper.findChild(slot0.viewGO, "bg/#go_targetContent/#go_descItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.baseId = slot0.viewParam.baseId

	slot0:createScoreItem()
	slot0:createTargetDescItem()
end

function slot0.createScoreItem(slot0)
	slot1 = {}

	for slot5 = 1, 3 do
		table.insert(slot1, Season166Config.instance:getSeasonScoreCo(slot0.actId, slot5))
	end

	gohelper.CreateObjList(slot0, slot0.scoreItemShow, slot1, slot0._gotargetScoreContent, slot0._gotargetItem)
end

function slot0.scoreItemShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_star/go_starIcon"), false)

	slot10 = slot2.needScore
	gohelper.findChildText(slot1, "txt_target").text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_targetscore"), {
		slot10
	})

	for slot10 = 1, slot2.star do
		gohelper.setActive(gohelper.cloneInPlace(slot5), true)
	end
end

function slot0.createTargetDescItem(slot0)
	gohelper.CreateObjList(slot0, slot0.targetDescItemShow, Season166Config.instance:getSeasonBaseTargetCos(slot0.actId, slot0.baseId), slot0._gotargetContent, slot0._godescItem)
end

function slot0.targetDescItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "txt_desc").text = slot2.targetDesc
end

function slot0.onClose(slot0)
	Season166HeroGroupController.instance:dispatchEvent(Season166Event.CloseHeroGroupTargetView)
end

function slot0.onDestroyView(slot0)
end

return slot0

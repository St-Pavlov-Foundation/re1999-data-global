module("modules.logic.versionactivity1_5.act142.view.game.Activity142GetCollectionView", package.seeall)

slot0 = class("Activity142GetCollectionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildImage(slot0.viewGO, "content/#go_collection/#simage_icon")
	slot0._txtcollectiontitle = gohelper.findChildText(slot0.viewGO, "content/#go_collection/#txt_collectiontitle")
	slot0._txtcollectiondesc = gohelper.findChildText(slot0.viewGO, "content/#go_collection/#txt_collectiontitle/#txt_collectiondesc")
	slot0._btnclose = gohelper.getClick(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	if not (slot0.viewParam and slot0.viewParam.collectionId) then
		logError("Activity142GetCollectionView error, collectionId is nil")

		return
	end

	if not Activity142Config.instance:getCollectionCfg(Activity142Model.instance:getActivityId(), slot1, true) then
		return
	end

	slot0._txtcollectiontitle.text = slot3.name
	slot0._txtcollectiondesc.text = slot3.desc

	if slot3.icon then
		UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._simageicon, slot3.icon)
	end

	Activity142Model.instance:setHasCollection(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_notebook_get)
end

function slot0.onClose(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RewardIsClose)
end

function slot0.onDestroyView(slot0)
end

return slot0

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionSelectView", package.seeall)

slot0 = class("V1a6_CachotCollectionSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._godisableconfirm = gohelper.findChild(slot0.viewGO, "#go_disableconfirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnReceiveFightReward, slot0._checkCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnReceiveFightReward, slot0._checkCloseView, slot0)
end

function slot0._editableInitView(slot0)
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
end

function slot0._btnconfirmOnClick(slot0)
	UIBlockMgr.instance:startBlock("V1a6_CachotCollectionSelectView_Get")

	if slot0._collectionItemTab and slot0._collectionItemTab[slot0._selectIndex] then
		if slot0.viewParam and slot0.viewParam.selectCallback and slot0._selectIndex then
			slot2(slot0.viewParam and slot0.viewParam.selectCallbackObj, slot0._selectIndex)
		else
			logError(string.format("selectCallBack or selectIndex is nil, selectIndex = %s", slot0._selectIndex))
		end
	else
		logError("cannot find collectionItem, index = " .. tostring(slot0._selectIndex))
	end
end

function slot0._checkCloseView(slot0)
	if slot0._animatorPlayer and slot0._playCollectionCloseAnimCallBack then
		slot0._animatorPlayer:Play("close", slot0._playCollectionCloseAnimCallBack, slot0)
		slot0:_closeOtherUnselectCollections()
	else
		slot0:closeThis()
	end
end

function slot0.onOpen(slot0)
	slot0:refreshGetCollectionList(slot0.viewParam and slot0.viewParam.collectionList)
	slot0:refreshConfirmBtnState()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_click)
end

function slot0.refreshGetCollectionList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot2[slot0:_getOrCreateCollectionItem(slot6)] = true

			if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot7) then
				slot8.simageIcon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot9.icon))

				slot8.txtName.text = slot9 and slot9.name or ""

				V1a6_CachotCollectionHelper.refreshSkillDesc(slot9, slot8.goskillcontainer, slot8.goskillItem)
				V1a6_CachotCollectionHelper.createCollectionHoles(slot9, slot8.goEnchantList, slot8.goHole)
			end
		end
	end

	slot0:_recycleUnUseCollectionItem(slot2)
end

function slot0._getOrCreateCollectionItem(slot0, slot1)
	slot0._collectionItemTab = slot0._collectionItemTab or {}

	if not slot0._collectionItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gocollectionitem, "collectionItem_" .. slot1)
		slot2.animator = gohelper.onceAddComponent(slot2.viewGO, gohelper.Type_Animator)
		slot2.imageBg = gohelper.findChildImage(slot2.viewGO, "#simage_bg")
		slot2.normalBg = gohelper.findChildImage(slot2.viewGO, "normal")

		UISpriteSetMgr.instance:setV1a6CachotSprite(slot2.imageBg, "v1a6_cachot_reward_bg1")

		slot2.simageIcon = gohelper.findChildSingleImage(slot2.viewGO, "#simage_collection")
		slot2.txtName = gohelper.findChildText(slot2.viewGO, "#txt_name")
		slot2.goSelect = gohelper.findChild(slot2.viewGO, "#go_select")
		slot2.btnSelect = gohelper.getClickWithDefaultAudio(slot2.viewGO)

		slot2.btnSelect:AddClickListener(slot0._onSelectCollection, slot0, slot1)

		slot2.goskillcontainer = gohelper.findChild(slot2.viewGO, "scroll_desc/Viewport/#go_skillcontainer")
		slot2.goskillItem = gohelper.findChild(slot2.viewGO, "scroll_desc/Viewport/#go_skillcontainer/#go_skillitem")
		slot2.goEnchantList = gohelper.findChild(slot2.viewGO, "#go_enchantlist")
		slot2.goHole = gohelper.findChild(slot2.viewGO, "#go_enchantlist/#go_hole")

		gohelper.setActive(slot2.viewGO, true)

		slot0._collectionItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onSelectCollection(slot0, slot1)
	slot0._selectIndex = slot1

	slot0:checkCollectionSelected(slot1)
	slot0:refreshConfirmBtnState()
end

function slot0.checkCollectionSelected(slot0, slot1)
	if slot0._collectionItemTab then
		for slot5, slot6 in ipairs(slot0._collectionItemTab) do
			gohelper.setActive(slot6.goSelect, slot1 == slot5)
			gohelper.setActive(slot6.normalBg, slot1 ~= slot5)
		end
	end
end

function slot0.refreshConfirmBtnState(slot0)
	slot1 = slot0._selectIndex and slot0._selectIndex ~= 0

	gohelper.setActive(slot0._godisableconfirm, not slot1)
	gohelper.setActive(slot0._btnconfirm.gameObject, slot1)
end

function slot0._releaseCallBackParam(slot0)
	if slot0.viewParam then
		slot0.viewParam.selectCallback = nil
		slot0.viewParam.selectCallbackObj = nil
	end
end

function slot0._recycleUnUseCollectionItem(slot0, slot1)
	if slot1 and slot0._collectionItemTab then
		for slot5, slot6 in pairs(slot0._collectionItemTab) do
			if not slot1[slot6] then
				gohelper.setActive(slot6.viewGO, false)
			end
		end
	end
end

function slot0._disposeAllCollectionItems(slot0)
	if slot0._collectionItemTab then
		for slot4, slot5 in pairs(slot0._collectionItemTab) do
			if slot5.btnSelect then
				slot5.btnSelect:RemoveClickListener()
			end
		end
	end
end

function slot0._closeOtherUnselectCollections(slot0)
	if slot0._collectionItemTab then
		for slot4, slot5 in ipairs(slot0._collectionItemTab) do
			if slot4 ~= slot0._selectIndex then
				slot5.animator:Play("collectionitem_close")
			end
		end
	end
end

function slot0._playCollectionCloseAnimCallBack(slot0)
	slot0:closeThis()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionSelectView_Get")
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionSelectView_Get")
end

function slot0.onDestroyView(slot0)
	slot0:_disposeAllCollectionItems()
	slot0:_releaseCallBackParam()
end

return slot0

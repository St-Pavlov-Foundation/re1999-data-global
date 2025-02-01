module("modules.logic.explore.view.ExploreBonusSceneRecordView", package.seeall)

slot0 = class("ExploreBonusSceneRecordView", BaseView)
slot1 = 8

function slot0._setContentPaddingTop(slot0, slot1)
	slot0._vLayoutGroup.padding.top = slot1
end

function slot0._updateContentPaddingTop(slot0, slot1)
	if slot1 then
		slot2 = slot0._originalPaddingTop + uv0
	end

	slot0:_setContentPaddingTop(slot2)
end

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._item = gohelper.findChild(slot0.viewGO, "mask/Scroll View/Viewport/Content/#go_chatitem")
	slot0._itemContent = gohelper.findChild(slot0.viewGO, "mask/Scroll View/Viewport/Content")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._vLayoutGroup = slot0._itemContent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	slot0._originalPaddingTop = slot0._vLayoutGroup.padding.top
	slot0._tmpMarkTopTextList = {}
	slot0._tmpMarkTopTextListList = {}
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot3, slot4 = next(ExploreSimpleModel.instance:getChapterMo(slot0.viewParam.chapterId).bonusScene)
	slot6 = {}
	slot7 = nil

	for slot11, slot12 in ipairs(slot4) do
		if ExploreConfig.instance:getDialogueConfig(slot3)[slot11] then
			if not string.nilorempty(slot13.bonusButton) then
				-- Nothing
			end

			table.insert(slot6, {
				desc = slot13.desc,
				options = string.split(slot13.bonusButton, "|"),
				index = slot12
			})

			if not string.nilorempty(slot13.picture) then
				slot7 = slot13.picture
			end
		end
	end

	if not string.nilorempty(slot7) then
		slot0._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. slot7))
	end

	gohelper.CreateObjList(slot0, slot0.onCreateItem, slot6, slot0._itemContent, slot0._item)
end

function slot0.onCreateItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChildTextMesh(slot1, "info"), slot2.desc)
	gohelper.setActive(gohelper.findChild(slot1, "bg"), slot2.options)

	if slot2.desc then
		if not slot0._tmpMarkTopTextList[slot3] then
			slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4.gameObject, TMPMarkTopText)

			slot6:setTopOffset(0, -5.2)
			slot6:setLineSpacing(15)

			slot0._tmpMarkTopTextList[slot3] = slot6
		else
			slot6:reInitByCmp(slot4)
		end

		slot6:setData(slot2.desc)
	end

	if slot3 == 1 then
		slot0:_updateContentPaddingTop(slot0._tmpMarkTopTextList[slot3]:isContainsMarkTop())
	end

	if slot2.options then
		for slot9 = 1, 3 do
			slot11 = gohelper.findChild(slot5, "txt" .. slot9 .. "/play")
			slot0._tmpMarkTopTextListList[slot3] = slot0._tmpMarkTopTextListList[slot3] or {}

			if not slot0._tmpMarkTopTextListList[slot3][slot9] then
				slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChildTextMesh(slot5, "txt" .. slot9).gameObject, TMPMarkTopText)

				slot13:setTopOffset(0, -5.5)
				slot13:setLineSpacing(7)

				slot0._tmpMarkTopTextListList[slot3][slot9] = slot13
			else
				slot13:reInitByCmp(slot10)
			end

			if slot2.options[slot9] then
				slot13:setData(slot2.options[slot9])
				gohelper.setActive(slot11, slot2.index == slot9)
				SLFramework.UGUI.GuiHelper.SetColor(slot10, slot2.index == slot9 and "#445D42" or "#3D3939")
			else
				gohelper.setActive(slot10, false)
			end
		end
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_tmpMarkTopTextList")

	if slot0._tmpMarkTopTextListList then
		for slot4, slot5 in pairs(slot0._tmpMarkTopTextListList) do
			for slot9, slot10 in pairs(slot5) do
				slot10:onDestroyView()
			end
		end

		slot0._tmpMarkTopTextListList = nil
	end

	slot0._simageicon:UnLoadImage()
end

return slot0

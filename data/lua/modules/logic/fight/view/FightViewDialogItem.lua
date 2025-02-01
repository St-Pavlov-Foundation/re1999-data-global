module("modules.logic.fight.view.FightViewDialogItem", package.seeall)

slot0 = class("FightViewDialogItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._fightViewDialog = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gocontainer = gohelper.findChild(slot1, "container/simagebg")
	slot0._simageicon = gohelper.findChildSingleImage(slot1, "container/simagebg/headframe/headicon")
	slot0._goframe = gohelper.findChild(slot1, "container/simagebg/headframe")
	slot0._txtdialog = gohelper.findChildText(slot1, "container/simagebg/go_normalcontent/txt_contentcn")
	slot0._goNormalContent = gohelper.findChild(slot1, "container/simagebg/go_normalcontent")

	if slot0._simageicon == nil then
		slot0._simageicon = gohelper.findChildSingleImage(slot1, "container/headframe/headicon")
	end

	if slot0._goframe == nil then
		slot0._goframe = gohelper.findChild(slot1, "container/headframe")
	end

	if slot0._txtdialog == nil then
		slot0._txtdialog = gohelper.findChildText(slot1, "container/go_normalcontent/txt_contentcn")
	end

	if slot0._goNormalContent == nil then
		slot0._goNormalContent = gohelper.findChild(slot1, "container/go_normalcontent")
	end

	slot0._canvasGroup = slot0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function slot0.showDialogContent(slot0, slot1, slot2)
	gohelper.setActive(slot0._goframe, slot1 ~= nil)
	gohelper.setActive(slot0._simageicon.gameObject, slot1 ~= nil)

	if slot1 then
		if slot0._simageicon.curImageUrl ~= slot1 then
			slot0._simageicon:UnLoadImage()
		end

		slot0._simageicon:LoadImage(slot1)
	end

	slot0._txtdialog.text = slot2.text

	slot0._txtdialog:GetPreferredValues()

	if not slot0._tmpFadeIn then
		slot0._tmpFadeIn = MonoHelper.addLuaComOnceToGo(slot0._gocontainer, TMPFadeIn)

		slot0._tmpFadeIn:setTopOffset(0, -2.4)
		slot0._tmpFadeIn:setLineSpacing(26)
	end

	slot0._tmpFadeIn:playNormalText(slot2.text)
	recthelper.setAnchorX(slot0._goframe.transform, slot2.tipsDir == 2 and 920 or 0)
	recthelper.setAnchorX(slot0._goNormalContent.transform, slot2.tipsDir == 2 and 382 or 529.2)

	slot3 = slot2.tipsDir == 2 and Vector2(1, 1) or Vector2(0, 1)
	slot0.go.transform.anchorMin = slot3
	slot0.go.transform.anchorMax = slot3

	recthelper.setAnchorX(slot0.go.transform, slot2.tipsDir == 2 and -1100 or 208.6)

	if slot0._gocontainer and slot0._gocontainer:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup)) then
		slot4.padding.left = slot2.tipsDir == 2 and -120 or 150
	end
end

function slot0.onDestroy(slot0)
	GameUtil.onDestroyViewMember(slot0, "_tmpFadeIn")
	slot0._simageicon:UnLoadImage()
end

return slot0

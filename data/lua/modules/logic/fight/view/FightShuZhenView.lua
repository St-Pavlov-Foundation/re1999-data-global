module("modules.logic.fight.view.FightShuZhenView", package.seeall)

slot0 = class("FightShuZhenView", BaseView)

function slot0.onInitView(slot0)
	slot0._topLeftRoot = gohelper.findChild(slot0.viewGO, "root/topLeftContent")
	slot0._obj = gohelper.findChild(slot0.viewGO, "root/topLeftContent/#go_shuzhentips")
	slot0._detail = gohelper.findChild(slot0.viewGO, "root/#go_shuzhendetails")
	gohelper.onceAddComponent(slot0._detail, typeof(UnityEngine.Animator)).enabled = true
	slot0._text = gohelper.findChildText(slot0._obj, "layout/shuzhenitem/#txt_task")
	slot0._red = gohelper.findChild(slot0._obj, "layout/shuzhenitem/#txt_task/red")
	slot0._blue = gohelper.findChild(slot0._obj, "layout/shuzhenitem/#txt_task/blue")
	slot0._red_round_num = gohelper.findChildText(slot0._obj, "layout/shuzhenitem/#txt_task/red/#txt_num")
	slot0._blue_round_num = gohelper.findChildText(slot0._obj, "layout/shuzhenitem/#txt_task/blue/#txt_num")
	slot0._detailHeightObj = gohelper.findChild(slot0.viewGO, "root/#go_shuzhendetails/details")
	slot0._detailTitle = gohelper.findChildText(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title")
	slot0._detailRound = gohelper.findChildText(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title/#txt_round")
	slot0._detailText = gohelper.findChildText(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_details")
	slot0._click = gohelper.getClickWithDefaultAudio(gohelper.findChild(slot0._obj, "layout/shuzhenitem"))
	slot0._detailClick = gohelper.getClickWithDefaultAudio(gohelper.findChild(slot0._detail, "#btn_shuzhendetailclick"))
	slot0._ani = gohelper.findChildComponent(slot0._obj, "layout/shuzhenitem", typeof(UnityEngine.Animator))
	slot0._aniPlayer = SLFramework.AnimatorPlayer.Get(slot0._ani.gameObject)
	slot0._redUpdate = gohelper.findChild(slot0._obj, "layout/shuzhenitem/update_red")
	slot0._blueUpdate = gohelper.findChild(slot0._obj, "layout/shuzhenitem/update_blue")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
	slot0._detailClick:AddClickListener(slot0._onDetailClick, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddMagicCircile, slot0._onAddMagicCircile, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DeleteMagicCircile, slot0._onDeleteMagicCircile, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateMagicCircile, slot0._onUpdateMagicCircile, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._detailClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._text.text = ""

	gohelper.setActive(slot0._obj, false)
	gohelper.setActive(slot0._detail, false)
	SkillHelper.addHyperLinkClick(slot0._detailText, slot0.onClickShuZhenHyperDesc, slot0)

	slot0.detailRectTr = slot0._detail:GetComponent(gohelper.Type_RectTransform)
	slot0.viewGoRectTr = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0.scrollRectTr = gohelper.findChildComponent(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details", gohelper.Type_RectTransform)
end

slot0.TipIntervalX = 10

function slot0.onClickShuZhenHyperDesc(slot0, slot1, slot2)
	slot0.commonBuffTipAnchorPos = slot0.commonBuffTipAnchorPos or Vector2()

	slot0.commonBuffTipAnchorPos:Set(-(recthelper.getWidth(slot0.viewGoRectTr) / 2 - recthelper.getAnchorX(slot0.detailRectTr) - recthelper.getWidth(slot0.scrollRectTr) - uv0.TipIntervalX), 312.24)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(slot1, slot0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Left)
end

function slot0._onClick(slot0)
	recthelper.setAnchorY(slot0._detail.transform, recthelper.rectToRelativeAnchorPos(slot0._text.transform.position, slot0._topLeftRoot.transform).y - slot0._text.preferredHeight + recthelper.getAnchorY(slot0._topLeftRoot.transform))
	gohelper.setActive(slot0._detail, true)
end

function slot0._onDetailClick(slot0)
	gohelper.setActive(slot0._detail, false)
end

function slot0.onOpen(slot0)
	if FightModel.instance:getMagicCircleInfo() and slot1.magicCircleId and lua_magic_circle.configDict[slot1.magicCircleId] then
		gohelper.setActive(slot0._obj, true)

		slot0._text.text = slot2.name

		gohelper.setActive(slot0._red, FightHelper.getMagicSide(slot1.createUid) == FightEnum.EntitySide.EnemySide)
		gohelper.setActive(slot0._blue, slot3 == FightEnum.EntitySide.MySide)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._text, slot3 == FightEnum.EntitySide.MySide and "#547ca6" or "#9f4f4f")

		slot5 = slot1.round == -1 and "∞" or slot1.round
		slot0._red_round_num.text = slot5
		slot0._blue_round_num.text = slot5
		slot0._detailTitle.text = slot2.name
		slot0._detailRound.text = formatLuaLang("x_round", slot5)
		slot0._detailText.text = SkillHelper.buildDesc(slot2.desc)
		slot0._curSide = slot3

		return
	end
end

function slot0._onAddMagicCircile(slot0)
	slot0:onOpen()
	slot0:_playAni("open")
end

function slot0._onDeleteMagicCircile(slot0)
	slot0:_playAni("close", slot0._hideObj, slot0)
end

function slot0._hideObj(slot0)
	gohelper.setActive(slot0._obj, false)
end

function slot0._onUpdateMagicCircile(slot0)
	slot0:onOpen()

	if FightModel.instance:getMagicCircleInfo() and slot1.magicCircleId and slot1.round == -1 then
		return
	end

	if slot0._curSide == FightEnum.EntitySide.MySide then
		gohelper.setActive(slot0._blueUpdate, false)
		gohelper.setActive(slot0._blueUpdate, true)
	else
		gohelper.setActive(slot0._redUpdate, false)
		gohelper.setActive(slot0._redUpdate, true)
	end
end

function slot0._playAni(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._obj, true)

	slot0._ani.speed = FightModel.instance:getSpeed()

	slot0._aniPlayer:Play(slot1, slot2, slot3)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

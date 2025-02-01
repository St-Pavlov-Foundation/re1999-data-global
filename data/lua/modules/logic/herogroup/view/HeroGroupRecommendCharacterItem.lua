module("modules.logic.herogroup.view.HeroGroupRecommendCharacterItem", package.seeall)

slot0 = class("HeroGroupRecommendCharacterItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._gounselectedbg = gohelper.findChild(slot1, "#go_info/#go_unselectedbg")
	slot0._gobeselectedbg = gohelper.findChild(slot1, "#go_info/#go_beselectedbg")
	slot0._txtcharactername = gohelper.findChildText(slot1, "#go_info/canvasgroup/#txt_charactername")
	slot0._txtrate = gohelper.findChildText(slot1, "#go_info/canvasgroup/#txt_rate")
	slot0._simagecharacter = gohelper.findChildSingleImage(slot1, "#go_info/canvasgroup/#simage_character")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "#go_info/#btn_click")
	slot0._goinfo = gohelper.findChild(slot1, "#go_info")
	slot0._gonull = gohelper.findChild(slot1, "#go_null")
	slot0._txtrank = gohelper.findChildText(slot1, "#txt_rank")
	slot0._gomask = gohelper.findChild(slot1, "#go_info/#go_mask")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo.isEmpty then
		return
	end

	if not slot0._isSelect then
		slot0._view:selectCell(slot0._index, true)
	end
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	if slot0._isSelect and not HeroGroupRecommendGroupListModel.instance:isShowSampleMo(slot0._mo) then
		HeroGroupRecommendGroupListModel.instance:setGroupList(slot0._mo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickRecommendCharacter)
	end

	gohelper.setActive(slot0._gounselectedbg, not slot0._isSelect)
	gohelper.setActive(slot0._gobeselectedbg, slot0._isSelect)
	slot0:_setInfoShowByStateType(slot0:_getCurStateType())
end

slot0.StateType = {
	UnSelectedUnOwner = 3,
	SelectedAndOwner = 2,
	SelectedUnOwner = 1,
	UnSelectedAndOwner = 4
}

function slot0._getCurStateType(slot0)
	slot1 = nil

	return not HeroModel.instance:getByHeroId(slot0._mo.heroId) and (slot0._isSelect and uv0.StateType.SelectedUnOwner or uv0.StateType.UnSelectedUnOwner) or slot0._isSelect and uv0.StateType.SelectedAndOwner or uv0.StateType.UnSelectedAndOwner
end

function slot0._setInfoShowByStateType(slot0, slot1)
	if slot1 == uv0.StateType.SelectedUnOwner or slot1 == uv0.StateType.SelectedAndOwner then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcharactername, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtcharactername, 1)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrate, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrate, 1)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrank, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrank, 0.4)

		slot0._txtcharactername.fontSize = 48
	elseif slot1 == uv0.StateType.UnSelectedUnOwner then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcharactername, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtcharactername, 0.3)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrate, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrate, 0.3)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrank, 0.15)

		slot0._txtcharactername.fontSize = 42
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcharactername, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtcharactername, 1)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrate, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrate, 1)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrank, 0.15)

		slot0._txtcharactername.fontSize = 42
	end

	gohelper.setActive(slot0._gomask, slot1 == uv0.StateType.UnSelectedUnOwner or slot1 == uv0.StateType.UnSelectedAndOwner)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._gonull, slot0._mo.isEmpty)
	gohelper.setActive(slot0._goinfo, not slot0._mo.isEmpty)

	slot0._txtrank.text = GameUtil.fillZeroInLeft(slot0._index, 2)

	if slot0._mo.isEmpty then
		gohelper.setActive(slot0._gounselectedbg, true)
		gohelper.setActive(slot0._gobeselectedbg, false)

		return
	end

	slot2 = HeroConfig.instance:getHeroCO(slot0._mo.heroId)
	slot0._txtcharactername.text = slot2.name
	slot0._txtrate.text = string.format("%s%%", math.floor(slot0._mo.rate * 10000) / 100)

	slot0._simagecharacter:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot2.skinId).headIcon))
end

function slot0.getAnimator(slot0)
	return slot0._anim
end

function slot0.onDestroy(slot0)
	slot0._simagecharacter:UnLoadImage()
end

return slot0

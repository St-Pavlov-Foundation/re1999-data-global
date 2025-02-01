module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapHeroView", package.seeall)

slot0 = class("YaXianMapHeroView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickDetail(slot0)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = slot0.heroId
	})
end

function slot0._editableInitView(slot0)
	slot0.simageHeroIcon = gohelper.findChildSingleImage(slot0.viewGO, "window/role/icon")
	slot0.detailClick = gohelper.findChildClick(slot0.viewGO, "window/role/icon/detail")
	slot0.txtName = gohelper.findChildText(slot0.viewGO, "window/role/name")

	slot0.detailClick:AddClickListener(slot0.onClickDetail, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.maxTrialTemplateId = YaXianModel.instance:getMaxTrialTemplateId()
	slot0.heroId, slot0.skinId = YaXianModel.instance:getHeroIdAndSkinId()

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.txtName.text = HeroConfig.instance:getHeroCO(slot0.heroId).name

	slot0:refreshHeroIcon()
end

function slot0.refreshHeroIcon(slot0)
	slot0.simageHeroIcon:LoadImage(ResUrl.getHeadIconMiddle(SkinConfig.instance:getSkinCo(slot0.skinId).retangleIcon))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simageHeroIcon:UnLoadImage()
	slot0.detailClick:RemoveClickListener()
end

return slot0

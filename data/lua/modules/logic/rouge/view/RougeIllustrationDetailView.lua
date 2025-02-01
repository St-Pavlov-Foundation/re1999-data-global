module("modules.logic.rouge.view.RougeIllustrationDetailView", package.seeall)

slot0 = class("RougeIllustrationDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageFrameBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FrameBG")
	slot0._simageBottomBG = gohelper.findChildSingleImage(slot0.viewGO, "Bottom/#simage_BottomBG")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_Name")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_Descr")
	slot0._txtPage = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_Page")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Left")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Right")
	slot0._goLeftTop = gohelper.findChild(slot0.viewGO, "#go_LeftTop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
end

function slot0._btnLeftOnClick(slot0)
	slot0._index = slot0._index - 1

	if slot0._index < 1 then
		slot0._index = slot0._num
	end

	slot0:_changePage()
end

function slot0._btnRightOnClick(slot0)
	slot0._index = slot0._index + 1

	if slot0._num < slot0._index then
		slot0._index = 1
	end

	slot0:_changePage()
end

function slot0._changePage(slot0)
	slot0._aniamtor:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(slot0._delayUpdateInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayUpdateInfo, slot0, 0.3)
end

function slot0._delayUpdateInfo(slot0)
	slot0:_updateInfo(slot0._list[slot0._index])
end

function slot0._editableInitView(slot0)
	slot0._txtNameEn = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_Name/txt_NameEn")
	slot0._aniamtor = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
end

function slot0._initIllustrationList(slot0)
	slot0._list = {}

	for slot5, slot6 in ipairs(RougeFavoriteConfig.instance:getIllustrationList()) do
		if RougeOutsideModel.instance:passedAnyEventId(slot6.eventIdList) then
			table.insert(slot0._list, slot6.config)
		end
	end

	slot0._num = #slot0._list
end

function slot0.onOpen(slot0)
	slot0:_initIllustrationList()

	slot0._index = tabletool.indexOf(slot0._list, slot0.viewParam) or 1

	slot0:_updateInfo(slot1)
end

function slot0._updateInfo(slot0, slot1)
	slot0._mo = slot1
	slot0._txtName.text = slot0._mo.name
	slot0._txtNameEn.text = slot0._mo.nameEn
	slot0._txtDescr.text = slot0._mo.desc
	slot0._txtPage.text = string.format("%s/%s", slot0._index, slot0._num)

	if not string.nilorempty(slot0._mo.fullImage) then
		slot0._simageFullBG:LoadImage(slot0._mo.fullImage)
	end

	if RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Illustration, slot0._mo.id) ~= nil then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Illustration, slot0._mo.id)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayUpdateInfo, slot0)
end

return slot0

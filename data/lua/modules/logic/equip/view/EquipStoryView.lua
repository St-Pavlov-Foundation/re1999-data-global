module("modules.logic.equip.view.EquipStoryView", package.seeall)

slot0 = class("EquipStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtnameEn = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_nameen")
	slot0._goskillpos = gohelper.findChild(slot0.viewGO, "#go_skillpos")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.txt_skilldesc = SLFramework.GameObjectHelper.FindChildComponent(slot0.viewGO, "desc/txt_skilldesc", typeof(TMPro.TextMeshProUGUI))
	slot0._viewAnim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.onOpen(slot0)
	slot0._equipMO = slot0.viewContainer.viewParam.equipMO
	slot0._equipId = slot0._equipMO and slot0._equipMO.config.id or slot0.viewContainer.viewParam.equipId
	slot0._config = slot0._equipMO and slot0._equipMO.config or EquipConfig.instance:getEquipCo(slot0._equipId)
	slot0._txtname.text = slot0._config.name
	slot0._txtnameEn.text = slot0._config.name_en
	slot0.txt_skilldesc.text = slot0._config.desc

	if slot0.viewContainer:getIsOpenLeftBackpack() then
		slot0.viewContainer.equipView:showTitleAndCenter()
	end

	slot0._viewAnim:Play(UIAnimationName.Open)
end

function slot0.onOpenFinish(slot0)
end

function slot0.onClose(slot0)
	slot0:playCloseAnimation()
end

function slot0.playCloseAnimation(slot0)
	slot0._viewAnim:Play(UIAnimationName.Close)
end

return slot0

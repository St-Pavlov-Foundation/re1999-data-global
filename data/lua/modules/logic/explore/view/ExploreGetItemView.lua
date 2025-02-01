module("modules.logic.explore.view.ExploreGetItemView", package.seeall)

slot0 = class("ExploreGetItemView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagepropicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_propicon")
	slot0._txtpropname = gohelper.findChildText(slot0.viewGO, "#txt_propname")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "#txt_desc")
	slot0._txtdesc2 = gohelper.findChildTextMesh(slot0.viewGO, "Scroll View/Viewport/Content/#txt_usedesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

	slot0._config = ExploreConfig.instance:getItemCo(slot0.viewParam.id)

	slot0._simagepropicon:LoadImage(ResUrl.getPropItemIcon(slot0._config.icon))

	slot0._txtpropname.text = slot0._config.name
	slot0._txtdesc.text = slot0._config.desc
	slot0._txtdesc2.text = slot0._config.desc2
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	ExploreController.instance:dispatchEvent(ExploreEvent.ShowBagBtn)
end

function slot0.onDestroyView(slot0)
	slot0._simagepropicon:UnLoadImage()
end

return slot0

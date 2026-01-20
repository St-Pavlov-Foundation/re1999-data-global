-- chunkname: @modules/logic/store/view/DecorateStoreGoodsTipView.lua

module("modules.logic.store.view.DecorateStoreGoodsTipView", package.seeall)

local DecorateStoreGoodsTipView = class("DecorateStoreGoodsTipView", RoomMaterialTipView)

function DecorateStoreGoodsTipView:_editableInitView()
	DecorateStoreGoodsTipView.super._editableInitView(self)

	self._simagetheme = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/iconmask/simage_theme")
	self._goitemContent = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/go_itemContent")
	self._simageinfobg = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/simage_infobg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc")
	self._txtname = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc/txt_name")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
end

function DecorateStoreGoodsTipView:_refreshUI()
	DecorateStoreGoodsTipView.super._refreshUI(self)
	gohelper.setActive(self._goitemContent.gameObject, false)
	gohelper.setActive(self._goslider.gameObject, false)
	self._simagetheme:LoadImage(ResUrl.getDecorateStoreBuyBannerFullPath(self._config.id), function()
		ZProj.UGUIHelper.SetImageSize(self._simagetheme.gameObject)
	end, self)

	self._txtdesc.text = self._config.desc
	self._txtname.text = self._config.name

	self._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))
end

function DecorateStoreGoodsTipView:onDestroyView()
	DecorateStoreGoodsTipView.super.onDestroyView(self)
	self._simagetheme:UnLoadImage()
	self._simageinfobg:UnLoadImage()
end

return DecorateStoreGoodsTipView

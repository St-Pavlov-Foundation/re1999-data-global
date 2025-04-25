module("modules.logic.settings.controller.SettingsEvent", package.seeall)

return {
	SelectCategory = 1,
	PlayCloseCategoryAnim = 2,
	OnChangeLangTxt = 3,
	OnChangeScrollValue = 4,
	OnChangeHDType = 5,
	OnDownloadPrepareStart = 100,
	OnNotEnoughDiskSpace = 101,
	OnDownloadStart = 102,
	OnDownloadProgressRefresh = 103,
	OnDownloadPackFail = 104,
	OnDownloadPackSuccess = 105,
	OnPackUnZipFail = 106,
	OnPackItemStateChange = 107,
	OnUnzipProgressRefresh = 108,
	OnUseCdkReplay = 200,
	OnMarkNeedDownloadChange = 301,
	OnChangeEnergyMode = 302,
	OnChangeSelecetDownloadVoicePack = 303,
	OnChangeVoiceType = 304,
	OnChangePushType = 401,
	OnSetVoiceRoleSelected = 501,
	OnCharVoiceTypeChanged = 502,
	OnSetVoiceRoleFiltered = 503,
	OnKeyMapChange = 601,
	OnKeyTipsChange = 602
}

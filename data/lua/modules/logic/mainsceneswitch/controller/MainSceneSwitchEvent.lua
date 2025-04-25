module("modules.logic.mainsceneswitch.controller.MainSceneSwitchEvent", package.seeall)

slot0 = _M
slot0.BeforeStartSwitchScene = GameUtil.getEventId()
slot0.StartSwitchScene = GameUtil.getEventId()
slot0.SwitchSceneFinish = GameUtil.getEventId()
slot0.SwitchSceneInitFinish = GameUtil.getEventId()
slot0.CloseSwitchSceneLoading = GameUtil.getEventId()
slot0.SwitchSceneFinishStory = GameUtil.getEventId()
slot0.ClickSwitchItem = GameUtil.getEventId()
slot0.SwitchCategoryClick = GameUtil.getEventId()
slot0.SceneSwitchUIVisible = GameUtil.getEventId()
slot0.PreviewSceneSwitchUIVisible = GameUtil.getEventId()
slot0.ShowSceneInfo = GameUtil.getEventId()
slot0.ShowPreviewSceneInfo = GameUtil.getEventId()

return slot0

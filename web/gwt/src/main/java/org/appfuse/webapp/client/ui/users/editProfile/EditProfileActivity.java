/**
 * 
 */
package org.appfuse.webapp.client.ui.users.editProfile;

import org.appfuse.webapp.client.application.Application;
import org.appfuse.webapp.client.application.base.activity.AbstractProxyEditActivity;
import org.appfuse.webapp.client.application.base.view.ProxyEditView;
import org.appfuse.webapp.client.proxies.RoleProxy;
import org.appfuse.webapp.client.proxies.UserProxy;
import org.appfuse.webapp.client.requests.UserRequest;
import org.appfuse.webapp.client.ui.mainMenu.MainMenuPlace;
import org.appfuse.webapp.client.ui.users.editUser.EditUserView;

import com.github.gwtbootstrap.client.ui.constants.AlertType;
import com.google.gwt.place.shared.Place;
import com.google.web.bindery.requestfactory.shared.Request;
import com.google.web.bindery.requestfactory.shared.RequestContext;

/**
 * @author ivangsa
 *
 */
public class EditProfileActivity extends AbstractProxyEditActivity<UserProxy> implements EditUserView.Delegate {

	
	public EditProfileActivity(Application application) {
		super(application);
		setTitle(i18n.userProfile_title());
		setDeleteConfirmation(i18n.delete_confirm(i18n.userList_user()));
	}
	

	@Override
	public String getSavedMessage() {
		return application.getI18n().user_saved();
	}
	
	@Override
	public String getDeletedMessage() {
		return application.getI18n().user_deleted(entityProxy.getUsername());
	}
	
	
	@Override
	protected ProxyEditView<UserProxy, ?> createView(Place place) {
		EditUserView editUserView = viewFactory.getView(EditProfileViewImpl.class);
		boolean isFullyAuthenticated = application.isUserInRole(RoleProxy.FULLY_AUTHENTICATED); 
		editUserView.hidePasswordFields(!isFullyAuthenticated);
		if(!isFullyAuthenticated) {
			shell.addMessage(i18n.userProfile_cookieLogin(), AlertType.WARNING);
		}
		
		if(editUserView != null) {
			editUserView.setAvailableRoles(application.getLookupConstants().getAvailableRoles());
			editUserView.setCountries(application.getLookupConstants().getCountries());
		}
		return editUserView;
	}

	@Override
	protected String getEntityId() {
		//return a not null entityId so super does not try to create a new profile
		return "x";
	}

	@Override
	protected RequestContext createProxyRequest() {
		return requests.userRequest();
	}
	
	@Override
	protected Request<UserProxy> loadProxyRequest(RequestContext requestContext, String proxyId) {
		return ((UserRequest) requestContext).editProfile();
	}
	

	@Override
	protected RequestContext saveOrUpdateRequest(RequestContext requestContext, UserProxy proxy) {
		((UserRequest) requestContext).editProfile(proxy);
		return requestContext;
	}	
	
	@Override
	protected RequestContext deleteRequest(RequestContext requestContext, UserProxy proxy) {
		throw new UnsupportedOperationException();
	}

	@Override
	protected Place previousPlace() {
		return new MainMenuPlace();
	}
	
	@Override
	protected Place nextPlace(boolean saved) {
		return new EditProfilePlace();
	}

}

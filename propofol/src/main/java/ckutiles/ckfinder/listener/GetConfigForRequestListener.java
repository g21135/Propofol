package ckutiles.ckfinder.listener;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cksource.ckfinder.config.Config;
import com.cksource.ckfinder.event.GetConfigForRequestEvent;
import com.cksource.ckfinder.listener.Listener;

import kr.or.ddit.vo.MemberVO;

/**
 * A listener that dynamically changes the location of user files on application
 * start.
 * <p>
 * It simply replaces the "{user.dir}" placeholder defined in the backend.root
 * configuration with value obtained from "user.dir" system property.
 */
@Named
public class GetConfigForRequestListener implements Listener<GetConfigForRequestEvent> {
	private static Logger logger = LoggerFactory.getLogger(GetConfigForRequestListener.class);
	
	@Override
	public void onApplicationEvent(GetConfigForRequestEvent event) {
		try {
//			String userDir = "D:/Util/eGovFrameDev-3.8.0-64bit/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/propofol/ckstorage";
			String userDir = "D:/B_Util/7.eGov/eGovFrameDev-3.8.0-64bit/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/propofol/ckstorage";
			Config config = event.getConfig();
			HttpSession session = event.getRequest().getSession();
			
			Map<String, Config.Backend> backendConfigs = config.getBackends();
			for (Config.Backend backendConfig : backendConfigs.values()) {
				if (backendConfig.getAdapter().equals("local")) {
					String originalRoot = backendConfig.getRoot();
					String newRoot = originalRoot.replace("{user.dir}", userDir);
					newRoot = newRoot.replace("{user.id}", ((MemberVO) session.getAttribute("authMember")).getMem_id());

					String originalBaseUrl = backendConfig.getBaseUrl();
					String newBaseUrl = originalBaseUrl.replace("{user.id}", ((MemberVO) session.getAttribute("authMember")).getMem_id());
					backendConfig.setRoot(newRoot);
					backendConfig.setBaseUrl(newBaseUrl);

					Path dirPath = Paths.get(newRoot);
					logger.info(String.format("Checking CKFinder files root directory for backend \"%s\"",
							backendConfig.getName()));

					if (Files.exists(dirPath) && Files.isDirectory(dirPath)) {
						logger.info(String.format("CKFinder files root directory for backend \"%s\": %s",
								backendConfig.getName(), dirPath));
					} else {
						logger.info(String.format("CKFinder files root directory for backend \"%s\" doesn't exist",
								backendConfig.getName()));
						try {
							Files.createDirectories(dirPath);

							logger.info(
									String.format("Created CKFinder files root directory for backend \"%s\" under %s",
											backendConfig.getName(), dirPath));
						} catch (IOException e) {
							logger.error(String.format(
									"Could not create CKFinder files root directory for backend \"%s\" under %s",
									backendConfig.getName(), dirPath));
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

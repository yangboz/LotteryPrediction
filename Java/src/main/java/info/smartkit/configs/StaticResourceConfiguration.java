package info.smartkit.configs;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class StaticResourceConfiguration extends WebMvcConfigurerAdapter {
    private static final String[] CLASSPATH_RESOURCE_LOCATIONS = {
            "classpath:/META-INF/resources/", "classpath:/resources/",
            "classpath:/static/", "classpath:/public/"};

    /**
     * Add our static resources folder mapping.
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //
        registry.addResourceHandler("/**").addResourceLocations(
                CLASSPATH_RESOURCE_LOCATIONS);
        //
        // Activiti repository resources(diagram picture,process BPM files).
        // registry.addResourceHandler("/repository/**").addResourceLocations("classpath:/repository/");
        // Jasper report
        registry.addResourceHandler("/static/**").addResourceLocations(
                "classpath:/static/");
        // registry.addResourceHandler("/reports/**").addResourceLocations("classpath:/reports/");
        //
        super.addResourceHandlers(registry);
    }

}
